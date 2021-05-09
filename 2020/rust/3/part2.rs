use std::fs;
use std::iter;

fn main() {
    let contents = fs::read_to_string("input.txt").unwrap();
    let lines = contents.split_terminator('\n').collect::<Vec<_>>();

    let slopes = vec![(1, 1), (1, 3), (1, 5), (1, 7), (2, 1)];

    let trees = slopes.iter().map(|(dr, dc)| {
        let indices = iter::successors(Some((0, 0)), |(row, col)| {
            if *row + 1 < lines.len() {
                Some((row + dr, (col + dc) % lines[0].len()))
            } else {
                None
            }
        });

        let skier = indices.map(|(row, col)| lines[row].as_bytes()[col]);

        skier.filter(|c| *c == b'#').count()
    });

    println!("{:?}", trees.reduce(|a, b| a * b).unwrap());
}
