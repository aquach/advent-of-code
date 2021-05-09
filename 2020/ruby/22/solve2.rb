require 'set'
require 'json'

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

p p1.length + p2.length

def game(p1, p2)
  p "NEW GAME"
  seen = Set.new

  loop do
    p [ p1, p2 ]
    if p1.empty? || p2.empty?
      winner = p1.empty? ? p2 : p1
      p "WINNER"
      return [ !p1.empty?, winner.reverse.each_with_index.map { |v, i| v * (i + 1) }.sum, winner.length ]
    end

    if seen.include?([ p1, p2 ].to_json)
      return [ true, 0 ]
    else
      seen << [ p1, p2 ].to_json

      p1c = p1.shift
      p2c = p2.shift

      if p1.length >= p1c && p2.length >= p2c
        p1w, = game(p1.take(p1c), p2.take(p2c))
      else
        if p1c > p2c
          p1w = true
        else
          p1w = false
        end
      end
    end

    if p1w
      p1 << p1c
      p1 << p2c
    else
      p2 << p2c
      p2 << p1c
    end
  end
end

p game(p1, p2)
