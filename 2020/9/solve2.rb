a = File.readlines('input.txt').map(&:to_i)

(0..a.length - 1).each do |i|
  (i..a.length - 1).each do |j|

    if a[i..j].sum == 1124361034
      p a[i..j].min + a[i..j].max
      exit
    end
  end
end
