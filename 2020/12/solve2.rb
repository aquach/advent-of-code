a = File.readlines('input.txt')

rotate = { 'E' => 'S', 'S' => 'W', 'W' => 'N', 'N' => 'E' }
rotater = rotate.invert

x = 0
y = 0
wx = 10
wy = -1

a.each do |ins|
  am = ins[1..-1].to_i
  case ins[0]
  when 'N'
    wy -= am
  when 'S'
    wy += am
  when 'E'
    wx += am
  when 'W'
    wx -= am
  when 'L'
    (am / 90).times do
      dx = wx
      dy = wy

      wx = dy
      wy = -dx
    end
  when 'R'
    (am / 90).times do
      dx = wx
      dy = wy

      wx = -dy
      wy = dx
    end
  when 'F'
    x += wx * am
    y += wy * am
  end
end

p x.abs + y.abs
