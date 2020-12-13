require 'set'

a = File.readlines('input.txt')

ts = a.first.to_i

buses = a.last.split(',').reject { |x| x == 'x' }.to_set.map(&:to_i)

p ts, buses

p buses.map { |b|
  [ b, (ts / b) * b + b - ts ]
}.min_by(&:last)
