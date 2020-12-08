require 'set'

def c(s)
  s
    .tr('F', '0')
    .tr('B', '1')
    .tr('L', '0')
    .tr('R', '1')
    .to_i(2)
end

seats =  File.readlines('input.txt')
  .map(&:strip)
  .map { |line|
    row_s = line[0..6]
    col_s = line[7..9]

    row = c(row_s)
    col = c(col_s)

    row * 8 + col
  }
  .to_set

  puts (seats.min..seats.max).to_set - seats
