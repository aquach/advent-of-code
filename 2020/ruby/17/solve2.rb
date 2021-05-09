a = File.readlines('input.txt').map(&:chomp)

grid = {}

a.each_with_index do |l, y|
  l.split('').each_with_index do |c, x|
    if c == '#'
      grid[[0, 0, x, y ]] = c
    end
  end
end

6.times do
  new_grid = {}

  wz = grid.keys.map { |a| a.take(2).map(&:abs) }.flatten.max + 1

  (-wz..wz).each do |w|
    (-wz..wz).each do |z|
      (-14..14).each do |x|
        (-14..14).each do |y|
          ns = 0
          (-1..1).each do |dw|
            (-1..1).each do |dz|
              (-1..1).each do |dx|
                (-1..1).each do |dy|
                  if !(dx == 0 && dy == 0 && dz == 0 && dw == 0)
                    if grid[[ w + dw, z + dz, x + dx, y + dy ]]
                      ns += 1
                    end
                  end
                end
              end
            end
          end

          if grid[[ w, z, x, y ]]
            if (ns == 2 || ns == 3)
              new_grid[[w, z, x, y]] = '#'
            end
          elsif (ns == 3)
            new_grid[[w, z, x, y]] = '#'
          end
        end
      end
    end
  end

  grid = new_grid
end



p grid.values.flatten.count('#')
