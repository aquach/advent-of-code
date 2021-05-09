require 'set'

ins = File.readlines('input.txt')
  .map { |l|
    i, c = l.split(' ')

    [ i, c.to_i ]
  }

acc = 0
pc = 0

seen = Set.new

loop do
  if seen.include?(pc)
    p acc
    exit
  end

  seen << pc

  i, c = ins[pc]

  case i
  when 'nop'
  when 'acc'
    acc += c
  when 'jmp'
    pc += c
    next
  end

  pc += 1
end
