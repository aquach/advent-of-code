require 'json'

a = File.readlines('input.txt').map(&:strip)

def neighbors(grid, row, col)
  count = 0
  (-1..1).each do |d|
    (-1..1).each do |e|
      if (d == 0 && e == 0)
        next
      end

      r = row
      c = col

      loop do
        r += d
        c += e

        if r < 0 || c < 0
          break
        end

        if (grid[r] || [])[c] != '.'
          if (grid[r] || [])[c] == '#'
            count += 1
          end
          break
        end
      end
    end
  end

  { '#' => [1] * count }
end

loop do
  b = a.map(&:dup)

  (0..b.length - 1).each do |row|
    (0..b.first.length - 1).each do |col|
      if a[row][col] == 'L' && (neighbors(a, row, col)['#'] || []).length == 0
        b[row][col] = '#'
      elsif a[row][col] == '#' && (neighbors(a, row, col)['#'] || []).length >= 5
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
