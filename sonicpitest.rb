time = 0.18

live_loop :sync do
  cues = [[:complete, :quarter_tick, :half_tick, :tick],
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
          [:quarter_tick]].ring.tick
  cues.map { |c| cue c }
  sleep time
end

sync :complete

class Percusion
  attr_accessor :sonido, :amps, :nombre, :prendido
  def initialize(nombre, sonido, amps, prendido = true)
    self.nombre = nombre
    self.sonido = sonido
    self.amps = amps
    self.prendido = prendido
  end
  
  def tiempo
    :quarter_tick
  end
  
  def proxima_amp
    return 0 unless prendido
    amps.ring.tick
  end
end

class PercusionAlAzar < Percusion
  def proxima_amp
    return 0 unless prendido
    rand(10)
  end
end


kick = Percusion.new(:kick, :drum_bass_hard, [4, 0, 0, 0], true)
# kick = Percusion.new(:kick, :drum_bass_hard, [3, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 3, 0, 0, 0, 2], true)
hihat = Percusion.new(:hihat, :drum_cymbal_closed, [0.5, 0.6, 0.8, 0.8], false)
snare = Percusion.new(:snare, :drum_snare_hard, [0, 0, 0, 0, 1, 0 , 0 ,0, 0, 0, 0, 0, 1, 0 , 0 ,0], false)
# percusiones = [kick, hihat, snare]
percusiones = [kick, hihat, snare]

live_loop :bass do
  with_fx :distortion, mix:0.5, distort:0.9 do
    sync :quarter_tick
    use_synth :dsaw
    melody =
      [nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
      [nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
      [nil, 48, 48, 48] * 4 + [nil, 47, 47, 47] * 4 + [nil, 57, 57, 57] * 4 +  [nil, 50, 50, 50] * 4
    note = melody.ring.tick
    
    ##| play [note - 12, note -24], release: 0.6, release: 0.2 if note
  end
end

percusiones.each do |percusion|
  live_loop (percusion.nombre) do
    sync percusion.tiempo
    sample percusion.sonido, amp: percusion.proxima_amp
  end
end

live_loop :lead do
  use_synth :dtri
  with_fx :echo, mix:0.3 do
    sync :quarter_tick
    melody = [nil,67,69,64,nil,nil, nil,nil] * 4 +
      [nil,67,69,76,nil,nil, nil,nil,
       nil,67,69,74,nil,nil, nil,nil] * 2
    note = melody.ring.tick
    ##| play [note, note+12, note-12], release: 0.2, attack: 0.02, sustain: 0.1, amp: 1.5
  end
end

live_loop :amen do
  sync :quarter_tick
  
  with_fx :distortion do
    note_amount = rand(1.5).round + 1
    notes = []
    note_amount.times do
      notes.push([0,5,11,12, 12].sample)
    end
    notes.uniq.map { |note|
      sample :loop_amen, onset: note
      sleep time/notes.size
    }
  end
end

##| live_loop :chords do
##|   use_synth :fm
##|   with_fx :echo, mix:0.5 do
##|     with_fx :reverb, mix:0.3 do
##|       sync :quarter_tick
##|       note = [69,72,81, 84].sample
##|       play [note, note+7, note+12], release: 0.4, amp: 1 if one_in(2)
##|     end
##|   end
##| end

live_loop :lead2 do
  sync :quarter_tick
  use_synth :chiplead
  note = [100, 96, 103, 100, 96, 105, 100, 96, 112, 100, 96, 105].ring.tick
  with_fx :ixi_techno, mix: 0.8 do
    ##| play [note - 24], amp: 2
  end
end
