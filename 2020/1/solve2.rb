nums = File.readlines('input.txt').map(&:to_i)

nums.each do |n1|
  nums.each do |n2|
    nums.each do |n3|
      if n1 + n2 + n3 == 2020
        puts n1 * n2 * n3
        exit
      end
    end
  end
end
