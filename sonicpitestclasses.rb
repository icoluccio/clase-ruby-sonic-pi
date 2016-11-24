

class Sincronizador
  attr_accessor :cancion
  def initialize(cancion)
    self.cancion = cancion
  end

  def sincronizar
    time = 0.2
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
    cancion.sleep time
  end
end

class Volumen
  @@volumenes = {}
  def self.cambiarVolumen(instrumento, volumen)
    @@volumenes[instrumento] = volumen
  end

  def self.obtenerVolumen(instrumento)
    return @@volumenes[instrumento] if !@@volumenes[instrumento].nil?
    1
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
  attr_accessor :sonido, :amps, :nombre
  def initialize( sonido, amps)
    self.sonido = sonido
    self.amps = amps
  end

  def sonar(cancion)
    cancion.sample sonido, amp: proxima_amp
  end

  def proxima_amp
    amps.ring.tick(sonido.to_s) * Volumen.obtenerVolumen(self)
  end
end

class Instrumento
  attr_accessor :melodia, :sonido
  def initialize(melodia, sonido)
    self.melodia = melodia
    self.sonido = sonido
  end

  def proxima_nota
    melodia.ring.tick
  end

  def sonar(cancion)
    cancion.use_synth sonido
    hacer_sonido(cancion)
  end

  def obtener_volumen
    Volumen.obtenerVolumen(self)
  end
end


class Bajo < Instrumento
  def hacer_sonido(cancion)
    cancion.with_fx :distortion, mix:0.5, distort:0.9 do
      nota = proxima_nota
      cancion.play [nota - 12, nota -24, nota], release: 0.6, release: 0.2, amp: obtener_volumen if nota
    end
  end
end

class Lider < Instrumento
  def hacer_sonido(cancion)
    cancion.with_fx :echo, mix:0.3 do
      nota = proxima_nota
      cancion.play [nota, nota+12, nota-12], release: 0.2, attack: 0.02, sustain: 0.1, amp: obtener_volumen
    end
  end
end

class Acordes < Instrumento
  def hacer_sonido(cancion)
    cancion.with_fx :echo, mix:0.5 do
      cancion.with_fx :reverb, mix:0.3 do
        nota = proxima_nota
        cancion.play [nota, nota+7, nota+12], release: 0.4, amp: obtener_volumen if cancion.one_in(2)
      end
    end

    def proxima_nota
      melodia.sample
    end
  end
end


class Amen < Instrumento
  attr_accessor :velocidad
  def initialize(velocidad = 2)
    self.velocidad = velocidad
  end
  def sonar(cancion)
    cancion.sync :semicorchea
    cancion.with_fx :distortion do
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
end
