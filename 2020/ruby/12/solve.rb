a = File.readlines('input.txt')

dir = 'E'

rotate = { 'E' => 'S', 'S' => 'W', 'W' => 'N', 'N' => 'E' }
rotater = rotate.invert

x = 0
y = 0

a.each do |ins|
  am = ins[1..-1].to_i
  case ins[0]
  when 'N'
    y -= am
  when 'S'
    y += am
  when 'E'
    x += am
  when 'W'
    x -= am
  when 'L'
    (am / 90).times do
      dir = rotater[dir]
    end
  when 'R'
    (am / 90).times do
      dir = rotate[dir]
    end
  when 'F'
    case dir
    when 'N'
      y -= am
    when 'S'
      y += am
    when 'E'
      x += am
    when 'W'
      x -= am
    end
  end
end

p x.abs + y.abs
