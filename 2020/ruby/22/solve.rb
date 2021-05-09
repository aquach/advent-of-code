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

a = a.slice_when { |f| f == '' }.to_a.map { |f|
  if f.last == ''
    f.pop
  end
  f
}

p1, p2 = a
p1.shift
p2.shift

p1 = p1.map(&:to_i)
p2 = p2.map(&:to_i)

p p1
p p2


loop do
  if p1.empty? || p2.empty?
    winner = p1.empty? ? p2 : p1
    p winner.reverse.each_with_index.map { |v, i| v * (i + 1) }.sum
    exit
  end

  p1c = p1.shift
  p2c = p2.shift

  if p1c > p2c
    p1 << p1c
    p1 << p2c
  else
    p2 << p2c
    p2 << p1c
  end
end
