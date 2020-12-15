a = File.read('input.txt').split(',').map(&:to_i)

nums = []

nums += a

last_index = nums[0..nums.length - 2].each_with_index.to_h
# p last_index

(30 * 1000 * 1000).times do
  # puts 'start'
  # p nums.last
  # p last_index
  last_index[nums[-2]] = nums.length - 2

  index = last_index[nums.last]
  # p [ 'index', index ]
  if !index.nil?
    nums << nums.length - index - 1
  else
    nums << 0
  end
  # p last_index
  # p nums
end

# p nums

p nums[30 * 1000 * 1000 - 1]
