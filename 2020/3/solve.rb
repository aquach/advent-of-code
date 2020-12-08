slopes = File.readlines('input.txt').map(&:strip)

puts slopes.each_with_index.count { |row, i|
  row[(i * 3) % row.length] == '#'
}
