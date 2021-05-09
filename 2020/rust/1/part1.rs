use std::fs;

fn main() {
    let contents = fs::read_to_string("input.txt").unwrap();
    let nums = contents
        .split_whitespace()
        .map(|l| l.parse::<i32>().unwrap())
        .collect::<Vec<_>>();

    'o: for x in &nums {
        for y in &nums {
            if x + y == 2020 {
                println!("{:?}", x * y);
                break 'o;
            }
        }
    }
}
