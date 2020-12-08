slopes = File.readlines('input.txt').map(&:strip)

a = [1, 3, 5, 7].map { |c|
  slopes.each_with_index.count { |row, i|
    row[(i * c) % row.length] == '#'
  }
}.reduce(&:*)

b = slopes.each_with_index.count { |row, i|
  i % 2 == 0 && row[(i / 2)  % row.length] == '#'
}

puts a * b
