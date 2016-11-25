amen = Amen.new(2)

live_loop :sync do
  Sincronizador.new(self, 0.22).sincronizar
end
##| live_loop :sync do
##|   Sincronizador.new(self, rand(1) / 4).sincronizar
##| end

live_loop :bateria do
  amen.sonar(self)
end

live_loop :acordes do
  with_fx :echo, mix:0.3 do
    sync :semicorchea
    use_synth :pluck
    play chord(:c4 + rand(1)*12.to_i, :m), amp: 1.5 if one_in(4)
  end
end

live_loop :lead do
  with_fx :reverb, mix:0.6 do
    sync :semicorchea
    use_synth :chiplead
    play :c3 + rand(1)*40.to_i, amp: 0.5 if one_in(2)
  end
end

Volumen.cambiarVolumen(amen,1)
