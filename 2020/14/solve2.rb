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

    addrs = addr.to_s(2).rjust(36, '0').split('').zip(mask.split('')).map { |b, m|
      if m == 'X'
        [ 0, 1 ]
      elsif m == '1'
        [ 1 ]
      elsif m == '0'
        [ b ]
      end
    }

    addrs = addrs.reduce(&:product).map(&:flatten).map(&:join)

    addrs.each do |m|
      mem[m] = v
    end
  end
end

p mem.values.sum
