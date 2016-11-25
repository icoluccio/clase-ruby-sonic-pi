class Sincronizador
  attr_accessor :cancion, :tiempo
  def initialize(cancion, tiempo)
    self.cancion = cancion
    self.tiempo = tiempo
  end

  def sincronizar
    cues = [[:semicorchea, :corchea, :negra],
            [:semicorchea],
            [:corchea, :semicorchea],
            [:semicorchea],
            [:semicorchea, :corchea, :negra],
            [:semicorchea],
            [:corchea, :semicorchea],
            [:semicorchea],
            [:semicorchea, :corchea, :negra],
            [:semicorchea],
            [:corchea, :semicorchea],
            [:semicorchea],
            [:semicorchea, :corchea, :negra],
            [:semicorchea],
            [:corchea, :semicorchea],
            [:semicorchea, :completo]].ring.tick
    cues.map { |c| cancion.cue c }
    cancion.sleep tiempo
  end
end

class Volumen
  @@volumenes = {}
  def self.cambiarVolumen(instrumento, volumen)
    @@volumenes[instrumento] = volumen
  end

  def self.obtenerVolumen(instrumento)
    return @@volumenes[instrumento] unless @@volumenes[instrumento].nil?
    0
  end
end




class Bateria
  attr_accessor :percusiones
  def initialize(percusiones)
    self.percusiones = percusiones
  end

  def sonar(cancion)
    percusiones.each do |percusion|
      percusion.sonar(cancion)
    end
  end
end


class Percusion
  attr_accessor :sonido, :fuerzas, :nombre
  def initialize( sonido, fuerzas)
    self.sonido = sonido
    self.fuerzas = fuerzas
  end

  def sonar(cancion)
    cancion.sample sonido, amp: proxima_fuerza
  end

  def proxima_fuerza
    fuerzas.ring.tick(sonido.to_s) * Volumen.obtenerVolumen(self)
  end
end

class Instrumento
  attr_accessor :melodia, :sonido
  def initialize(melodia, sonido)
    self.melodia = melodia
    self.sonido = sonido
  end

  def proxima_nota
    melodia.ring.tick self.class.to_s
  end

  def sonar(cancion)
    cancion.use_synth sonido
    cancion.with_fx efecto, mix:nivel_de_efecto do
      hacer_sonido(cancion, proxima_nota)
    end
  end

  def obtener_volumen
    Volumen.obtenerVolumen(self)
  end

  def efecto
    :distortion
  end

  def nivel_de_efecto
    0
  end

  def hacer_sonido(cancion)
    raise 'Implementá esto'
  end
end


class Bajo < Instrumento
  def nivel_de_efecto
    0.6
  end

  def notas_a_tocar
    nota = proxima_nota
    [nota - 12, nota -24, nota]
  end

  def hacer_sonido(cancion, nota)
    cancion.play [nota - 12, nota -24, nota], release: 0.6, release: 0.2, amp: obtener_volumen
  end
end

class Lider < Instrumento
  def efecto
    :echo
  end

  def nivel_de_efecto
    0.5
  end

  def hacer_sonido(cancion, nota)
    cancion.play [nota, nota+12, nota-12], release: 0.2, attack: 0.02, sustain: 0.1, amp: obtener_volumen
  end
end

class Acordes < Instrumento
  def efecto
    :echo
  end

  def nivel_de_efecto
    rand(0.5)
  end

  def hacer_sonido(cancion, nota)
    cancion.play [nota, nota+7, nota+12], release: 0.4, amp: obtener_volumen if cancion.one_in(2)
  end

  def proxima_nota
    melodia.sample
  end
end

class Amen < Instrumento
  attr_accessor :velocidad
  def initialize(velocidad = 2)
    self.velocidad = velocidad
  end

  def sonar(cancion)
    cancion.sync :semicorchea
      cantidad_de_notas = rand(1.5).round + velocidad
      notas = []
      cantidad_de_notas.times do
        notas.push([0,5,11,12, 12].sample)
      end
      notas.uniq.map { |nota|
        cancion.sample :loop_amen, onset: nota, amp: obtener_volumen
        cancion.sleep 0.2/notas.size
      }
  end
end
