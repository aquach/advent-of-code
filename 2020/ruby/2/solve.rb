pws = File.readlines('input.txt').map { |l|
  policy, password = l.split(':')
  range, char = policy.split(' ')
  low, high = range.split('-')

  [ low.to_i, high.to_i, char, password.strip ]
}

puts pws.count { |low, high, char, pw|
  c = pw.count(char)
  c >= low && c <= high
}
