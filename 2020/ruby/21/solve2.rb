require 'set'

if false
  a = File.readlines('sampleinput.txt').map(&:chomp)
else
  a = File.readlines('input.txt').map(&:chomp)
end

# if 0
#   def p(*args)
#     $a = args
#   end
#   at_exit { Kernel.p(*$a) }
# end

# a = a.slice_when { |f| f == '' }.to_a.map { |f|
#   if f.last == ''
#     f.pop
#   end
#   f
# }

# p a

a = a.map { |f|
  ing, alls = f.split('(contains')

  [ ing.split(' '), alls[0..-2].split(', ').map(&:strip) ]
}

prefilter = a.flat_map { |ings, alls|
  alls.map { |al| [ al, ings.to_set ] }
}.group_by(&:first).map { |k, v| [ k, v.map(&:last).reduce(&:&) ] }.to_h
# p prefilter
# exit

# p a
$a = a

NUM = a.flat_map(&:last).uniq.length

def solve(rules, all_map)
  # p rules.length
  if rules.empty? && all_map.length == NUM
    p "DONE"
    p $a.flat_map(&:first).reject { |f| all_map.values.include?(f) }.length
    p all_map.sort_by(&:first).map(&:last).join(",")
    exit
  end

  ings, alls = rules.first

  # p rules.first

  alls.each do |a|
    if all_map[a] && !ings.include?(all_map[a])
      return
    end
  end

  ings = (ings.to_set - all_map.values.flatten.to_set).to_a
  alls = (alls.to_set - all_map.keys.to_set).to_a

  bindings = ings.combination(alls.length)
  allbs = bindings.flat_map { |f| f.permutation.to_a }

  allbs.each do |b|
    proposed = alls.zip(b).to_h

    # shared_keys = proposed.keys.to_set & all_map.keys.to_set
    # if all_map.slice(*shared_keys) == proposed.slice(*shared_keys)
      prop = all_map.merge(proposed)
      # p [ "trying", proposed ]
      solve(rules.drop(1), prop)
    # end
  end
end

# p "HI"
a = prefilter.values.map(&:to_a)
a.first.product(*a[1..-1]).each do |s|
  prop = prefilter.keys.zip(s).to_h
  if prop.values.uniq.length == prop.values.length
    solve($a, prop)
  end
end

# solve(a.sort_by { |b, c| c.length }, {})
