nums = File.readlines('input.txt').map(&:to_i)

nums.each do |n1|
  nums.each do |n2|
    if n1 + n2 == 2020
      puts n1 * n2
      exit
    end
  end
end
