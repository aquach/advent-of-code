require 'set'

ins = File.readlines('input.txt')
  .map { |l|
    i, c = l.split(' ')

    [ i, c.to_i ]
  }

def terminates(ins)
  acc = 0
  pc = 0

  seen = Set.new

  loop do
    if seen.include?(pc)
      return false
    end

    if pc == ins.length
      return acc
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
end

ins.each_with_index do |(i, c), index|
  p [i ,c, index ]
  if i == 'nop'
    ins[index] = [ 'jmp', c]
    acc = terminates(ins)
    if acc
      p acc
      exit
    end
    ins[index] = [ 'nop', c]
  elsif i == 'jmp'
    ins[index] = [ 'nop', c]
    acc = terminates(ins)
    if acc
      p acc
      exit
    end
    ins[index] = [ 'jmp', c]
  else
  end
end
