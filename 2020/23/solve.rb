require 'set'

if !true
  a = File.readlines('sampleinput.txt').map(&:chomp)
else
  a = File.readlines('input.txt').map(&:chomp)
end

if !true
  def p(*args)
    $a = args
  end
  at_exit { Kernel.p(*$a) }
end

# a = a.slice_when { |f| f == '' }.to_a.map { |f|
#   if f.last == ''
#     f.pop
#   end
#   f
# }

cups = a.first.split('').map(&:to_i)

100.times do

  cc = cups.first
  cs = cups.drop(1).take(3)
  cups = cups.take(1) + cups.drop(4)

  finder = cc - 1
  loop do
    if finder < cups.min
      finder = cups.max
    end

    dest = cups.find { |c| c == finder }
    if dest
      break
    else
      finder -= 1
    end
  end

  p "DEST", finder
  fi = cups.index(finder)

  cups = cups.take(fi + 1) + cs + cups.drop(fi + 1)
  cups = cups.drop(1) + cups.take(1)
end

fi = cups.index(1)

cups = cups.drop(fi) + cups.take(fi)

p cups.drop(1).join
