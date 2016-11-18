time = 0.22

kick = Percusion.new(:kick, "C:/Users/Pedro Soto/Desktop/kick.wav", [3, 0, 0, 0], true)
##| kick = Percusion.new(:kick, "C:/Users/Pedro Soto/Desktop/kick.wav", [3, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 3, 0, 0, 0, 2], true)
hihat = Percusion.new(:hihat, "C:/Users/Pedro Soto/Desktop/hat.wav", [0.5, 0.6, 0.8, 0.8], true)
snare = Percusion.new(:snare, "C:/Users/Pedro Soto/Desktop/snare.wav", [0, 0, 0, 0, 1, 0 , 0 ,0, 0, 0, 0, 0, 1, 0 , 0 ,0], true)
percusiones = [kick, hihat, snare]
bajo = Bajo.new([nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
                [nil, 53, 53, 53] * 4 + [nil, 55, 55, 55] * 4 + [nil, 50, 50, 50] * 8 +
                [nil, 48, 48, 48] * 4 + [nil, 47, 47, 47] * 4 + [nil, 57, 57, 57] * 4 +  [nil, 50, 50, 50] * 4, :dpulse)
##| bajo = Bajo.new([48,60]* 8 + [55,67] * 8 + [57,69] * 8 + [50,62] * 8, :dpulse)
##| lead = Lead.new([nil,76,nil,69,nil,88, 86,88], :dtri)

lead = Lead.new([nil,67,69,64,nil,nil, nil,nil] * 4 +
                [nil,67,69,76,nil,nil, nil,nil,
                 nil,67,69,74,nil,nil, nil,nil] * 2, :dtri)

acordes = Acordes.new([69,72,81,84], :fm)


lead2 =  Lead.new([67, 64, 60, 69,
                   64, 72, 76, 69,
                   60, 69, 64, 60,
                   60, nil, nil, nil], :chiplead)

amen = Amen.new(2)



Volumen.cambiarVolumen(kick, 0)
Volumen.cambiarVolumen(hihat, 0)
Volumen.cambiarVolumen(snare, 0)
Volumen.cambiarVolumen(bajo, 1)
Volumen.cambiarVolumen(lead, 1)
Volumen.cambiarVolumen(lead2, 0)
Volumen.cambiarVolumen(acordes, 0)
Volumen.cambiarVolumen(amen, 0)


live_loop :sync do
  Sync.new(self).sync
end

sync :complete

percusiones.each do |percusion|
  live_loop (percusion.nombre) do
    sync :quarter_tick
    percusion.tocar(self)
  end
end

live_loop :bass do
  sync :quarter_tick
  bajo.tocar(self)
end

live_loop :lead do
  sync :quarter_tick
  lead.tocar(self)
end

live_loop :chords do
  sync :quarter_tick
  acordes.tocar(self)
end

live_loop :lead3 do
  sync :quarter_tick
  lead2.tocar(self)
end

live_loop :amen do
  amen.tocar(self)
end

