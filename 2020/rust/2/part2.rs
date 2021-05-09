use std::fs;

fn main() {
    let contents = fs::read_to_string("input.txt").unwrap();
    let lines = contents.split_terminator('\n').map(|l| {
        let mut i = l.split_whitespace();
        let mut range = i.next().unwrap().split("-");
        (
            range.next().unwrap().parse::<usize>().unwrap(),
            range.next().unwrap().parse::<usize>().unwrap(),
            i.next()
                .unwrap()
                .strip_suffix(":")
                .unwrap()
                .parse::<char>()
                .unwrap(),
            i.next().unwrap(),
        )
    });

    let count = lines
        .filter(|(first, second, chr, pw)| {
            (pw.chars().nth(*first - 1).unwrap() == *chr)
                ^ (pw.chars().nth(*second - 1).unwrap() == *chr)
        })
        .count();

    println!("{:?}", count);
}
