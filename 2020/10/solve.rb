require 'set'

$adapters = File.readlines('input.txt').map(&:to_i).sort

def solve(adapters, used, diffs, jolt)
  if used.length == adapters.length
    p (diffs.count(3) + 1) * diffs.count(1)
    exit
  end
  adapters.each.select { |s| s >= jolt + 1 && s <= jolt + 3 }.each do |chosen|
    solve(adapters, used + Set.new([ chosen ]), diffs + [ chosen - jolt ], chosen)
  end
end

solve($adapters, Set.new, [], 0)
