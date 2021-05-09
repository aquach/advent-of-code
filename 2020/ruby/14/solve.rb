a = File.readlines('input.txt')

mask = nil

mem = {}

a.each do |l|
  if l['mask']
    mask = l.split('=').last.strip
  end

  if l['mem']
    addr, v = l.split('=')
    addr = addr[4..-3].to_i
    v = v.to_i

    v = v.to_s(2).rjust(36, '0').split('').zip(mask.split('')).map { |b, m|
      if m == 'X'
        b
      elsif m == '1'
        1
      elsif m == '0'
        0
      end
    }.join.to_i(2)

    mem[addr] = v
  end
end

p mem.values.sum
