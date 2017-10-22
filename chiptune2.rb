
use_bpm 120

live_loop :ritmo do
  play_pattern_timed chord(:d, :minor), [0.5,1,1]
end

# Batería
live_loop :kick do
  sample  :bd_fat, amp: 10
  sleep 1
end

live_loop :snare do
  sleep 1
  sample  :sn_dolf, amp: 5
  sleep 1
end

live_loop :hihat do
  sleep 0.25
  sample :drum_cymbal_closed, amp: 2
  sleep 0.25
  sample :drum_cymbal_closed, amp: 5
  sleep 0.25
  sample :drum_cymbal_closed, amp: 2
  sleep 0.25
end

live_loop :bajo do
  use_synth :fm
  play_pattern_timed [:d2,:d3,:d2,:d3]*6 + [:f2,:f3,:f2,:f3]*2 +
    [:c2,:c3,:c2,:c3]*6 + [:g2,:g3,:g2,:g3]*2, [0.5], amp:2, release:0.4
end

live_loop :lider do
  # use_synth :mod_sine
  
  use_synth :chiplead
  play_pattern_timed [:f4,:e4, :d4, :d5,
                      :f4,:e4, :d4, :a4,
                      :f4,:e4, :d4, :f5,
                      :f4,:e4, :d4, :g4], [0.25, 0.25, 0.5, 1], amp:1, release:1, decay: 0.5
end


