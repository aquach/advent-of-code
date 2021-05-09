require 'set'

$rules = File.readlines('input.txt').map { |l|
  outer, inner = l.split("contain")

  [
    outer.strip.gsub(/s$/, ''),
    inner.split(", ").map { |b|
      if !b['no other bag']
        count, bag = b.split(' ', 2)
        [ bag.gsub(/[s.]*$/, '').strip, count.to_i ]
      end
    }.compact
  ]
}.to_h

def count(bag)
  inners = $rules[bag]
  if inners == nil
    0
  else
    inners.map { |b, c|
      c * (count(b) + 1)
    }.sum
  end
end

p count('shiny gold bag')

