require 'set'

a = File.read('input.txt').gsub(/\n([a-z])/, ' \1').split("\n")

puts a.map { |group|
  group.split(" ").map { |s| s.split("").to_set }.reduce { |a, b| a & b }.count
}.sum


