require 'set'

a = File.readlines('input.txt')

rules = a.take(20).map { |l|
  n, r = l.split(':')
  [ n , r.split(' or ').map { |r| r.split('-').map(&:to_i) } ]
}

$mine = a[22].split(',').map(&:to_i)

valids = a.drop(25).map { |t|
  fields = t.split(',').map(&:to_i)
  if fields.all? { |f| rules.flat_map(&:last).any? { |l, h| f >= l && f <= h } }
    fields
  end
}.compact

$could_work = {}

rules.each do |r, ranges|
  valids.transpose.each_with_index do |col, i|
    $could_work[i] ||= []
    if col.all? { |f| ranges.any? { |l, h| f >= l && f <= h } }
      $could_work[i] << r
    end
  end
end

def solve(valids, used)
  if valids.length == used.length
    p used.zip($mine).select { |f, _| f[/^departure/ ] }.map(&:last).reduce(&:*)
    exit
  end

  possible_rules = $could_work[used.length].each.select { |r| !used.include?(r) }

  possible_rules.each do |r|
    solve(valids, used + [ r ])
  end
end

solve(valids.transpose, [])
