kick = Percusion.new("C:/Users/Pedro Soto/Desktop/hhkick.wav", [1, 0, 0, 0, 0, 0, 1, 0,
                                                                0, 0, 1, 0, 0, 1, 0, 0])
hihat = Percusion.new("C:/Users/Pedro Soto/Desktop/hhhh.wav", [0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0,
                                                               0.5, 0, 0.5, 0, 0.5, 0, 0.5, 0.3])
redoblante = Percusion.new("C:/Users/Pedro Soto/Desktop/hhsnare.wav", [0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0, 0,
                                                                       0, 0, 0, 0, 1, 0, 0.5, 0.5])
bateria = Bateria.new([kick, hihat, redoblante])
bajo = Bajo.new([:f3, nil, :f3, :f4, nil, nil, :f3, nil,
                 :f3, nil, :f3, :f4, nil, nil, :f3, nil,
                 :b2, nil, :b2, :b3, nil, nil, :b2, nil,
                 :b2, nil, :b2, :cs3, nil, :cs3, :d3, :d3], :sine)

##| bajo = Bajo.new([:f3, nil, :f4, :f5, nil, :f3, :f3, :f3,
##|                  :as3, nil, :as3, :cs3, nil, :f3, :f3, :f3,
##|                  :b2, nil, :b2, :b3, nil, nil, :b2, nil,
##|                  :b2, nil, :b2, nil, nil, nil, :d3, :d3], :sine)


live_loop :sync do
  Sincronizador.new(self, 0.17).sincronizar
end

live_loop :bateria do
  sync :semicorchea
  bateria.sonar(self)
end
live_loop :bajo do
  sync :semicorchea
  bajo.sonar(self)
end

Volumen.cambiarVolumen(bateria,1)
Volumen.cambiarVolumen(kick,1)
Volumen.cambiarVolumen(redoblante,1)
Volumen.cambiarVolumen(hihat,1)
Volumen.cambiarVolumen(bajo, 1)

with_fx :reverb, mix:0.4 do
  live_loop :acordes do
    use_synth :dtri
    with_fx :echo , mix:0.1 do
      sync :semicorchea
      play_chord chord(:f4, :minor)
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      play_chord chord(:bb3,  'm')
      sync :semicorchea

      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea


      sync :semicorchea
      play_chord chord(:eb4, 'm9+5')
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea


      sync :semicorchea
      play_chord chord(:b3, 'm9+5')
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
      play_chord chord(:b3, 'm7+9')
      sync :semicorchea
      sync :semicorchea
      sync :semicorchea
    end
  end
end
