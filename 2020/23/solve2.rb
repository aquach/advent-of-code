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

# CUPS = 999999
# TIMES = 10 * 1000 * 1000

CUPS = 25
TIMES = 1001

cups += ((cups.max + 1)..CUPS).to_a

moves = TIMES

while moves > 0 do
  # puts "next", moves

  # if moves < 9750000
  #   p cups.take(250)
  #   exit
  # end
  p cups

  hs = 0
  f = cups.first
  while cups[hs + 1] > cups[hs] do
    hs += 1
  end

  if hs > 0 && false
    opts = [ hs / 4, moves ].min

    if opts > 0
      puts "found run of #{hs}"
      puts "moving ahead #{opts} moves"

      fourths = (0..opts - 1).map { |i| cups[i * 4] }
      others = (0..(opts * 4) - 1).map { |i| i % 4 == 0 ? nil : cups[i] }.compact

      finder = f - 1 == 0 ? cups.max : f - 1
      fi = cups.index { |c| c == finder }
      cups = cups.take(fi + 1) + others + cups.drop(fi + 1)
      cups = cups.drop(opts * 4)
      cups += fourths

      moves -= opts
      next
    end
  end

  moves -= 1

  cc = cups.first
  cs = cups[1..3]
  cups = cups.take(1) + cups.drop(4)

  finder = cc - 1
  loop do
    if finder < 1
      finder = cups.max
    end

    dest = cups.find { |c| c == finder }
    if dest
      break
    else
      finder -= 1
    end
  end

  fi = cups.index(finder)

  cups = cups.take(fi + 1) + cs + cups.drop(fi + 1)
  g = cups.shift
  cups << g
end

fi = cups.index(1)
# p [ cups[(fi + 1) % cups.length], cups[(fi + 2) % cups.length] ]
