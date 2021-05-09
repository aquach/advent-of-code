require 'set'

if !true
  a = File.readlines('sampleinput.txt').map(&:chomp)
else
  a = File.readlines('input.txt').map(&:chomp)
end

if !true
  def p(*args)
    $a = args
  end
  at_exit { Kernel.p(*$a) }
end

a = a.map { |l|
  l.split('').slice_when { |g| g == 'e' || g == 'w' }.map { |f| f.join }
}

$dirs = {
  'e' => [ 1, 0 ],
  'ne' => [ 1, -1 ],
  'nw' => [ 0, -1 ],
  'w' => [ -1, -0 ],
  'sw' => [ -1, 1 ],
  'se' => [ 0, 1 ],
}

black = {}

a.each do |ins|
  x = 0
  y = 0
  ins.each do |d|
    dx, dy = $dirs[d]

    x += dx
    y += dy
  end

  black[[x, y]] = !black[[x, y]]
end


def ns(x, y)
  $dirs.values.map { | dx, dy| [ x + dx, y + dy] }
end

100.times do
  # p black
  p black.values.count(true)
  new_black = {}

  tiles = (black.keys.flat_map { |x, y| ns(x, y) } + black.keys).uniq

  # p tiles.count

  tiles.each do |x, y|
    nb = ns(x, y).map { |nx, ny| black[[nx, ny]] || false }.count(true)

    # p [ x, y, black[[x, y]], nb ]

    new_black[[x, y]] = black[[x, y]]

    if black[[x, y]] && (nb == 0 || nb > 2)
      new_black[[x, y]] = false
    end
    if !black[[x, y]] && nb == 2
      new_black[[x, y]] = true
    end
  end

  black = new_black
end

p black.values.count(true)
