require 'linked-list'

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

cups = a.first.split('').map(&:to_i)

CUPS = 1000000
TIMES = 10 * 1000 * 1000

# CUPS = 0
# TIMES = 100

acups = cups + ((cups.max+1)..CUPS).to_a
cups = LinkedList::List.new
acups.each do |c|
  cups << c
end

# p cups.to_a.take(25)
# p cups.to_a.last(25)
# p cups.to_a.length
# exit

lookup = cups.each_node.map { |n| [ n.data, n ] }.to_h

TIMES.times do |i|
  if i % 100000 == 0
    p i
  end
  # p cups.to_a
  cc = cups.send(:__shift)
  c1 = cups.send(:__shift)
  c2 = cups.send(:__shift)
  c3 = cups.send(:__shift)

  finder = cc.data - 1
  loop do
    new_finder = nil
    if finder == 0
      new_finder = CUPS
    end

    if finder == c3.data; new_finder = c3.data - 1 end
    if finder == c2.data; new_finder = c2.data - 1 end
    if finder == c1.data; new_finder = c1.data - 1 end

    if new_finder == nil
      break
    else
      finder = new_finder
    end
  end

  cursor = lookup[finder]
  # p cursor
  # p cups.to_a
  cups.insert_after_node(c3, cursor)
  # p cups.to_a
  cups.insert_after_node(c2, cursor)
  # p cups.to_a
  cups.insert_after_node(c1, cursor)
  # p cups.to_a
  cups << cc
end

cups = cups.to_a
# p cups
fi = cups.index(1)
p cups[(fi + 1) % cups.length] * cups[(fi + 2) % cups.length]
