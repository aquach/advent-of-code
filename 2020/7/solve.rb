require 'set'

rules = File.readlines('input.txt').map { |l|
  outer, inner = l.split("contain")

  [
    outer.strip.gsub(/s$/, ''),
    inner.split(", ").map { |b| b.gsub(/[0-9.]/, '').strip.gsub(/s$/, '').strip }.to_set
  ]
}

set = [ 'shiny gold bag' ].to_set

loop do
  changed = false
  rules.each do |outer, inners|
    if !(set & inners).empty? && !set.include?(outer)
      changed = true
      set << outer
    end
  end

  if !changed
    p set.length - 1
    exit
  end
end

