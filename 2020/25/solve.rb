require 'set'

if !true
  a = File.readlines('sampleinput.txt').map(&:chomp)
else
  a = File.readlines('input.txt').map(&:chomp)
end

door, card = a.map(&:to_i)

def find_loop(pkey)
  n = 1

  count = 0
  loop do
    if n == pkey
      return count
    end

    count += 1

    n = n * 7 % 20201227
  end
end

loops = find_loop(door)

n = 1
loops.times do
  n = n * card % 20201227
end

p n

