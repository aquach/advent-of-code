require 'set'

KEYS = %w(byr iyr eyr hgt hcl ecl pid).to_set

puts File.read('input.txt')
  .gsub(/\n([a-z])/, ' \1')
  .split("\n")
  .count { |l|
    kvs = l.split(' ').map { |kv| kv.split(':') }.to_h
    next unless (KEYS - kvs.keys).empty?

    byr = kvs['byr'].to_i
    iyr = kvs['iyr'].to_i
    eyr = kvs['eyr'].to_i

    hgt = kvs['hgt'][0..-3].to_i
    suffix = kvs['hgt'][-2..-1]

    next unless suffix == 'cm' || suffix == 'in'

    byr >= 1920 && byr <= 2002 &&
      iyr >= 2010 && iyr <= 2020 &&
      eyr >= 2020 && eyr <= 2030 &&
      (
        (suffix == 'cm' && hgt >= 150 && hgt <= 193) ||
        (suffix == 'in' && hgt >= 59 && hgt <= 76)
      ) &&
      kvs['hcl'][/^#[0-9a-f]{6}$/] &&
      %w(amb blu brn gry grn hzl oth).include?(kvs['ecl']) &&
      kvs['pid'][/^[0-9]{9}$/]
  }
