use std::fs;
use std::iter;

fn main() {
    let contents = fs::read_to_string("input.txt").unwrap();
    let lines = contents.split_terminator('\n').collect::<Vec<_>>();

    let indices = iter::successors(Some((0, 0)), |(row, col)| {
        if *row + 1 < lines.len() {
            Some((row + 1, (col + 3) % lines[0].len()))
        } else {
            None
        }
    });

    let skier = indices.map(|(row, col)| lines[row].as_bytes()[col]);

    let trees = skier.filter(|c| *c == b'#').count();
    println!("{:?}", trees);
}
