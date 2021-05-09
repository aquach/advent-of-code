require 'set'

a = File.read('input.txt').gsub(/\n([a-z])/, ' \1').split("\n")

puts a.map { |group|
  group.strip.split("").map(&:strip).reject(&:empty?).to_set.count
}.sum


