$adapters = File.readlines('input.txt').map(&:to_i).sort

dp = [0] * $adapters.max

dp[0] = 1

$adapters.each do |a|
  dp[a] = dp[a - 1] + dp[a - 2] + dp[a - 3]
end

p dp[-1]
