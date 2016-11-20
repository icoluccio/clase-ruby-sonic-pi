kick = Percusion.new("C:/Users/Pedro Soto/Desktop/hhkick.wav", [1, 0, 0, 0, 0, 0, 1, 0,
                                                                0, 0, 1, 0, 0, 1, 0, 0])
hihat = Percusion.new("C:/Users/Pedro Soto/Desktop/hhhh.wav", [0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0,
                                                               0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0.3])
snare = Percusion.new("C:/Users/Pedro Soto/Desktop/hhsnare.wav", [0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0, 0,
                                                                  0, 0, 0, 0, 1, 0, 0.5, 0.5])
bateria = Bateria.new([kick, hihat, snare])
bajo = Bajo.new([:f3, nil, :f3, :f4, nil, nil, :f3, nil,
                 :f3, nil, :f3, :f4, nil, nil, :f3, nil,
                 :b2, nil, :b2, :b3, nil, nil, :b2, nil,
                 :b2, nil, :b2, :cs3, nil, :cs3, :d3, :d3], :sine)

live_loop :sync do
  Sync.new(self, 0.15).sync
end

live_loop :bateria do
  sync :quarter_tick
  ##| bateria.tocar(self)
end
live_loop :bajo do
  sync :quarter_tick
  ##| bajo.tocar(self)
end

live_loop :hum do
  use_synth :dtri
  with_fx :reverb, mix:0.4 do
    with_fx :echo , mix:0.1 do
      sync :quarter_tick
      play_chord chord(:f4, :minor)
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      play_chord chord(:bb3,  'm')
      sync :quarter_tick
      
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      
      
      sync :quarter_tick
      play_chord chord(:eb4, 'm9+5')
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      
      
      sync :quarter_tick
      play_chord chord(:b3, 'm9+5')
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
      play_chord chord(:b3, 'm7+9')
      sync :quarter_tick
      sync :quarter_tick
      sync :quarter_tick
    end
  end
end
