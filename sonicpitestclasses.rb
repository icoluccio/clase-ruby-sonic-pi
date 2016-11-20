

class Sync
  attr_accessor :song
  def initialize(song)
    self.song = song
  end
  
  def sync
    time = 0.2
    cues = [[:quarter_tick, :half_tick, :tick],
            [:quarter_tick],
            [:half_tick, :quarter_tick],
            [:quarter_tick],
            [:half_tick, :quarter_tick],
            [:quarter_tick],
            [:quarter_tick, :half_tick, :tick],
            [:quarter_tick],
            [:half_tick, :quarter_tick],
            [:quarter_tick],
            [:half_tick, :quarter_tick],
            [:quarter_tick, :complete]].ring.tick
    cues.map { |c| song.cue c }
    song.sleep time
  end
end

class Volumen
  @@volumenes = {}
  def self.cambiarVolumen(algo, volumen)
    @@volumenes[algo] = volumen
  end
  
  def self.obtenerVolumen(algo)
    return @@volumenes[algo] if !@@volumenes[algo].nil?
    1
  end
end




class Bateria
  attr_accessor :percusiones
  def initialize(percusiones)
    self.percusiones = percusiones
  end
  def tocar(cancion)
    puts "1"
    percusiones.each do |percusion|
      percusion.tocar(cancion)
    end
  end
end


class Percusion
  attr_accessor :sonido, :amps, :nombre
  def initialize( sonido, amps)
    self.sonido = sonido
    self.amps = amps
  end
  
  def tocar(cancion)
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
  
  def tocar(cancion)
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
      note = proxima_nota
      cancion.play [note - 12, note -24, note], release: 0.6, release: 0.2, amp: obtener_volumen if note
    end
  end
end

class Lead < Instrumento
  def hacer_sonido(cancion)
    cancion.with_fx :echo, mix:0.3 do
      note = proxima_nota
      cancion.play [note, note+12, note-12], release: 0.2, attack: 0.02, sustain: 0.1, amp: obtener_volumen
    end
  end
end

class Acordes < Instrumento
  def hacer_sonido(cancion)
    cancion.with_fx :echo, mix:0.5 do
      cancion.with_fx :reverb, mix:0.3 do
        note = proxima_nota
        cancion.play [note, note+7, note+12], release: 0.4, amp: obtener_volumen if cancion.one_in(2)
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
  def tocar(cancion)
    cancion.sync :quarter_tick
    cancion.with_fx :distortion do
      note_amount = rand(1.5).round + velocidad
      notes = []
      note_amount.times do
        notes.push([0,5,11,12, 12].sample)
      end
      notes.uniq.map { |note|
        cancion.sample :loop_amen, onset: note, amp: obtener_volumen
        cancion.sleep 0.2/notes.size
      }
    end
  end
end