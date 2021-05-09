a = File.read('input.txt').split(',').map(&:to_i)

nums = []

nums += a

2020.times do
  index = nums[0..-2].rindex { |n| n == nums.last }
  if !index.nil?
    nums << nums.length - index - 1
  else
    nums << 0
  end
end

p nums[2019]
