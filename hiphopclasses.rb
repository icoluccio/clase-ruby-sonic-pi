

class Sync
  attr_accessor :song, :tiempo
  def initialize(song, tiempo)
    self.song = song
    self.tiempo = tiempo
  end
  
  def sync
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
    song.sleep tiempo
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
    amps.ring.tick(sonido.to_s)
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
      cancion.play [note - 12, note -24], attack:0.02, release: 0.2, decay: 0.05 if note
    end
  end
end