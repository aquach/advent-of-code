a = File.readlines('input.txt')

$rules = a.take(139).map { |f|
  no, rest = f.split(':')
  no = no.to_i

  if rest['a']
    [ no, 'a' ]
  elsif rest['b']
    [ no, 'b' ]
  else
    alts = rest.split('|')

    [ no, alts.map { |g| g.split(' ').map(&:to_i) } ]
  end
}.to_h


def consume(s, rule_id=0)
  if s == ''
    return ''
  end

  rule = $rules[rule_id]

  if rule == 'a'
    if s[0] == 'a'
      return s[1..-1]
    else
      return nil
    end
  end

  if rule == 'b'
    if s[0] == 'b'
      return s[1..-1]
    else
      return nil
    end
  end

  rule.each do |alt|
    cs = s
    alt.each do |r|
      if !cs.nil?
        cs = consume(cs, r)
      end
    end

    if !cs.nil?
      return cs
    end
  end

  return nil
end

p a.drop(140).map(&:strip).count { |s| consume(s) == '' }
