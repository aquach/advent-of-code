require 'active_support/core_ext/hash/except.rb'

a = File.readlines('input.txt').map(&:strip)

a = a.slice_when { |f| f == '' }.to_a.map { |f|
  if f.last == ''
    f.pop
  end

  name = f.shift

  name = name[/[0-9]+/].to_i

  [ name, f]
}

a.map(&:last).each do |f|
  if f.length != 10
    raise
  end
  if f.map(&:length).uniq != [ 10 ]
    raise
  end
end


def rotate(t)
    t.map { |f| f.split("") }.transpose.map(&:reverse).map { |f| f.join("") }
end

def rotates(t)
  [ rotate(t), rotate(rotate(t)), rotate(rotate(rotate(t))) ]
end

def flips(t)
  [ t.map(&:reverse), t.reverse ]
end

D = 12

if a.length != D * D || a.to_h.length != D * D
  raise
end

def search(placed, ids, tiles)
  # p [ ids ]
  # (0..D-1).each do |row|
  #   (0..D-1).map do |col|
  #     puts placed[[ row, col]]
  #     puts
  #   end
  # end

  if placed.length == D * D
    p ids
    p ids[0] * ids[D - 1] * ids.last * ids[-1 - (D - 1)]
    grid = {}
    (0..D-1).each do |row|
      (0..D-1).each do |col|
        (0..7).each do |tr|
          (0..7).each do |tc|
            grid[[ row * 8 + tr, col * 8 + tc]] = placed[[ row, col ]][tr + 1][tc + 1]
          end
        end
      end
    end

    dd = ""
    (0..95).each do |r|
      (0..95).each do |c|
        dd += grid[[r, c]]
      end
      dd += "\n"
    end
    File.write('grid.txt', dd)

    exit
  end

  tiles.each do |id, kinds|
    # puts kinds.map { |f| f.join("\n") }.join("\n\n")
    # exit

    index = placed.length
    row = index / D
    col = index % D

    kinds.each do |k|
      top = placed[[ row - 1, col]]
      left = placed[[row, col - 1]]

      if id == 2473
        puts "TILE"
        puts k
        puts "DONE"

        puts "TOP"
        puts top
        puts "LEFT"
        puts left
        puts "MATCH"
        puts left && [ left.map { |f| f[-1] }.join, k.map { |f| f[0] }.join ].join("\n")
        puts "DONE"
      end

      if (!top || top.last == k.first) && (!left || left.map { |f| f[-1] } == k.map { |f| f[0] })
        search(
          placed.merge({ [row, col] => k }),
          ids + [ id ],
          tiles.reject { |f, _| f == id }
        )
      end
    end
  end
end

# puts "GO"
# puts a.sort_by(&:first).map { |k, t| [ k, [ t ] + rotates(t) + flips(t) ]}.to_h[2473].map { |f| f.join("\n") }.join("\n\n")
# exit

search(
  {},
  [],
  a.sort_by(&:first).map { |k, t| [
    k,
    ([ t ] + rotates(t) + flips(t) + flips(t).flat_map { |r| [ rotate(r), rotate(rotate(r)), rotate(rotate(rotate(r))) ] }).uniq
  ]}.to_h#.slice(1951,2311,3079, 2729,1427,2473, 2971,1489,1171)
)



