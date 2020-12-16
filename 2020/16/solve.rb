a = File.readlines('input.txt')

rules = a.take(20).flat_map { |l| l.split(':').last.split(' or ').map { |r| r.split('-').map(&:to_i) } }
p rules

p a.drop(25).join(',').split(',').map(&:to_i).select { |o|
  !rules.any? { |l, h| o >= l && o <= h }
}.sum
