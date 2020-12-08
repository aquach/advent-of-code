require 'set'

KEYS = %w(byr iyr eyr hgt hcl ecl pid).to_set

puts File.read('input.txt')
  .gsub(/\n([a-z])/, ' \1')
  .split("\n")
  .count { |l|
    keys = l.split(' ').map { |kv| kv.split(':').first }.to_set

    (KEYS - keys).empty?
  }
