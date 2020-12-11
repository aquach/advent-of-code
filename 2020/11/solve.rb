require 'json'

a = File.readlines('input.txt').map(&:strip)

def neighbors(c, row, col)
  count = []
  (-1..1).each do |d|
    (-1..1).each do |e|
      if !(d == 0 && e == 0)
        if row + d >= 0 && e + col >= 0
          count << (c[row + d] || [])[e + col]
        end
      end
    end
  end

  count.compact.group_by(&:itself)
end

loop do
  b = a.map(&:dup)

  (0..b.length - 1).each do |row|
    (0..b.first.length - 1).each do |col|
      if a[row][col] == 'L' && (neighbors(a, row, col)['#'] || []).length == 0
        b[row][col] = '#'
      elsif a[row][col] == '#' && (neighbors(a, row, col)['#'] || []).length >= 4
        b[row][col] = 'L'
      end
    end
  end

  if a.to_json == b.to_json
    p a.join("").count('#')
    exit
  end

  a = b
end
