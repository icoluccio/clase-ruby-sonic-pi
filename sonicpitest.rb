time = 0.22


kick = Percusion.new("C:/Users/Pedro Soto/Desktop/kick.wav", [1, 0, 0, 0])
hihat = Percusion.new("C:/Users/Pedro Soto/Desktop/hat.wav", [0, 0.6, 0.7, 0.6])
redoblante = Percusion.new("C:/Users/Pedro Soto/Desktop/redoblante.wav", [0, 0, 0, 0, 1, 0, 0, 0])
bateria = Bateria.new([kick, hihat, redoblante])

bajo = Bajo.new([nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
                [nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
                [nil, 48, 48, 48] * 4 + [nil, 47, 47, 47] * 4 + [nil, 57, 57, 57] * 4 +  [nil, 50, 50, 50] * 4, :dpulse)
##| bajo = Bajo.new([48,60]* 8 + [55,67] * 8 + [57,69] * 8 + [50,62] * 8, :dpulse)
##| lider = Lider.new([nil,76,nil,69,nil,88, 86,88], :dtri)

lider = Lider.new([nil,67,69,64,nil,nil, nil,nil] * 4 +
                [nil,67,69,76,nil,nil, nil,nil,
                 nil,67,69,74,nil,nil, nil,nil] * 2, :dtri)

acordes = Acordes.new([69,72,81,84], :fm)


lider2 =  Lider.new([67, 64, 60, 69,
                   64, 72, 76, 69,
                   60, 69, 64, 60,
                   60, nil, nil, nil], :chiplider)

amen = Amen.new(2)



Volumen.cambiarVolumen(bateria, 1)
Volumen.cambiarVolumen(bajo, 0)
Volumen.cambiarVolumen(lider, 0)
Volumen.cambiarVolumen(lider2, 0)
Volumen.cambiarVolumen(acordes, 0)
Volumen.cambiarVolumen(amen, 0)


live_loop :sync do
  Sincronizador.new(self).sincronizar
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

live_loop :chords do
  sync :semicorchea
  acordes.sonar(self)
end

live_loop :lider3 do
  sync :semicorchea
  lider2.sonar(self)
end

live_loop :amen do
  amen.sonar(self)
end
