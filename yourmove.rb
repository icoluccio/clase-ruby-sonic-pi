# Welcome to Sonic Pi v2.11.1
use_bpm 43.5

live_loop :sample do
  with_fx :reverb, mix: 0.6 do
    sample 'C:\Users\Pedro Soto\Downloads\SonicPiPortable\yourmove.wav', amp: 2, beat_stretch: 16
    sleep 16
  end
end

live_loop :drums do
  with_fx :slicer, wave: 0, mix: 0, phase: 0.125 do
    # sample :loop_amen, amp: 1.7, beat_stretch:2
  end
  sleep 1
end

live_loop :random_drums do
  # sample :loop_amen, amp: 1.7, onset: [0,5,11,12,12].sample
  sleep 0.125/2
end

live_loop :bass do
  use_synth :saw
  notes = [nil, :e2, :e3, :e2]*4 + [nil, :b1, :b2, :b1]*4 +
    [nil, :e2, :e3, :e2]*4  + [nil, :b2, :b3, :b2]*4 +
    [nil, :e2, :e3, :e2]*4 + [nil, :b1, :b2, :b1]*4 +
    [nil, :cs2, :cs3, :cs2]*4  + [nil, :d2, :d3, :d2]*2 + [nil, :e1, :e2, :e1]*2
  # play_pattern_timed notes, 0.125, release: 0.1, amp: 1
end

live_loop :lead do
  use_synth :dtri
  with_fx :echo, mix: 0.3 do
    # play choose(scale(:b4, :minor)), amp: 0.6, release: 0.1, attack: 0.1
  end
  sleep 0.125
end

live_loop :chords do
  use_synth :dtri
  with_fx :slicer, mix: 0.7 do
    with_fx :reverb, mix: 0.7 do
      with_fx :echo, mix: 0.7 do
        # play_pattern_timed chord(:b3, :minor7), 2, amp: 1, release: 1, attack: 1
      end
    end
  end
end