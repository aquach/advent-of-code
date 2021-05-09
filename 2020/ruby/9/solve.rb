a = File.readlines('input.txt').map(&:to_i)

a.each_cons(26).map { |group|
  n = group.last
  ns = group[0..-2]

  found = false
  ns.each do |n1|
    ns.each do |n2|
      if n1 + n2 == n
        found = true
      end
    end
  end

  if !found
    p n
    exit
  end
}
