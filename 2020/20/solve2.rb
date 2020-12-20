a = File.readlines('grid.txt').map(&:strip)

def rotate(t)
    t.map { |f| f.split("") }.transpose.map(&:reverse).map { |f| f.join("") }
end

def rotates(t)
  [ rotate(t), rotate(rotate(t)), rotate(rotate(rotate(t))) ]
end

def flips(t)
  [ t.map(&:reverse), t.reverse ]
end

monster = <<F
                  #
#    ##    ##    ###
 #  #  #  #  #  #
F

monster = monster.split("\n").each_with_index.flat_map { |line, i|
  line.split("").each_with_index.select { |s, _| s == '#' }.map(&:last).map { |c| [ i, c ] }
}

kinds = ([ a ] + rotates(a) + flips(a) + flips(a).flat_map { |r| [ rotate(r), rotate(rotate(r)), rotate(rotate(rotate(r))) ] }).uniq

k = kinds[2]
num = 0

claimed = k.map(&:dup)

(0..a.length).each do |offr|
  (0..a.length).each do |offc|
    if monster.all? { |mr, mc| (k[offr + mr] || [])[offc + mc] == '#' }
      monster.each do |mr, mc|
        if (k[offr + mr] || [])[offc + mc] == '#'
          claimed[offr + mr][offc + mc] = '%'
        end
      end
      num += 1
    end
  end
end

p num
puts k.join("\n")
puts
puts claimed.join("\n")
puts
p a.join.count('#')
p claimed.join.count('#')
