kick = Percusion.new("C:/Users/Pedro Soto/Desktop/kick.wav", [1, 0, 0, 0])
hihat = Percusion.new("C:/Users/Pedro Soto/Desktop/hat.wav", [0, 0.6, 0.7, 0.6])
redoblante = Percusion.new("C:/Users/Pedro Soto/Desktop/snare.wav", [0, 0, 0, 0, 1, 0, 0, 0])
bateria = Bateria.new([kick, hihat, redoblante])

_ = nil
bajo = Bajo.new([_, 53, 53, 53] * 4 + [_, 55, 55, 55] * 4 + [_, 50, 50, 50] * 8 +
                [_, 53, 53, 53] * 4 + [_, 55, 55, 55] * 4 + [_, 50, 50, 50] * 8 +
                [_, 48, 48, 48] * 4 + [_, 47, 47, 47] * 4 + [_, 57, 57, 57] * 4 +  [_, 50, 50, 50] * 4, :dpulse)

lider = Lider.new([_, 67, 69, 64, _, _, _, _] * 4 +
                  [_, 67, 69, 76, _, _, _, _,
                   _, 67, 69, 74, _, _, _, _] * 2, :dtri)

acordes = Acordes.new([69,72,81,84], :fm)


lider2 =  Lider.new([67, 64, 60, 69,
                     64, 72, 76, 69,
                     60, 69, 64, 60,
                     60, _, _, _], :chiplead)

amen = Amen.new(2)

# Cancion 2
##| kick = Percusion.new("C:/Users/Pedro Soto/Desktop/kick.wav", [0.5, 0, 0, 0])
##| hihat = Percusion.new("C:/Users/Pedro Soto/Desktop/hat.wav", [0.4, 0.7, 0.4, 0.7])
##| redoblante = Percusion.new("C:/Users/Pedro Soto/Desktop/snare.wav", [0, 0, 0, 0, 0, 0, 1, 0])
##| bateria = Bateria.new([kick, hihat, redoblante])
##| bajo = Bajo.new([48]* 16 + [55] * 16 + [45] * 16 + [50] * 16, :dpulse)
##| lider = Lider.new([nil,76,nil,74,nil,72, 79,nil,
##|                    nil,76,nil,74,nil,72, 79,nil,
##|                    64,nil,nil,72,nil,74, 72,nil,
##|                    nil,76,nil,74,nil,74, 81,nil], :fm)



Volumen.cambiarVolumen(bateria,0)
Volumen.cambiarVolumen(kick,0)
Volumen.cambiarVolumen(redoblante,0)
Volumen.cambiarVolumen(hihat,0)
Volumen.cambiarVolumen(bajo, 0.8)
Volumen.cambiarVolumen(lider, 1)
Volumen.cambiarVolumen(lider2, 0)
Volumen.cambiarVolumen(acordes, 0)
Volumen.cambiarVolumen(amen, 0.5)


live_loop :sync do
  Sincronizador.new(self, 0.2).sincronizar
end

sync :completo

live_loop :bass do
  sync :semicorchea
  bajo.sonar(self)
end
live_loop :bateria do
  sync :semicorchea
  bateria.sonar(self)
end

live_loop :lider do
  sync :semicorchea
  lider.sonar(self)
end

live_loop :acordes do
  sync :semicorchea
  acordes.sonar(self)
end

live_loop :lider3 do
  sync :semicorchea
  lider2.sonar(self)
end

live_loop :amen do
  with_fx :distortion do
    amen.sonar(self)
  end
end
