a = File.readlines('input.txt').map(&:chomp)

grid = {}

a.each_with_index do |l, y|
  l.split('').each_with_index do |c, x|
    if c == '#'
      grid[[0, x, y ]] = c
    end
  end
end

6.times do
  p grid

  new_grid = {}

  (-12..12).each do |z|
    (-12..12).each do |x|
      (-12..12).each do |y|
        ns = 0
        (-1..1).each do |dz|
          (-1..1).each do |dx|
            (-1..1).each do |dy|
              if !(dx == 0 && dy == 0 && dz == 0)
                if grid[[ z + dz, x + dx, y + dy ]]
                  ns += 1
                end
              end
            end
          end
        end

        if grid[[ z, x, y ]]
          if (ns == 2 || ns == 3)
            new_grid[[z, x, y]] = '#'
          end
        elsif (ns == 3)
          new_grid[[z, x, y]] = '#'
        end
      end
    end
  end

  grid = new_grid
end



p grid.values.flatten.count('#')
