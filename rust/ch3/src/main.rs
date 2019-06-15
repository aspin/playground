fn main() {
    assert!(fahrenheit_to_celsius(32.0) == 0.0);
    assert!(fahrenheit_to_celsius(-40.0) == -40.0);

    assert!(fibonacci(0) == 0);
    assert!(fibonacci(1) == 1);
    assert!(fibonacci(2) == 1);
    assert!(fibonacci(3) == 2);
    assert!(fibonacci(4) == 3);
    assert!(fibonacci(5) == 5);
    assert!(fibonacci(6) == 8);

    println!("{}", song_lyrics(12));
}

fn fahrenheit_to_celsius(degrees: f64) -> f64 {
    (degrees - 32.0) * 5.0 / 9.0
}

fn fibonacci(number: u64) -> u64 {
    if number == 0 {
        return 0;
    }
    if number == 1 {
        return 1;
    }
    let mut last_number = 1;
    let mut last_last_number = 0;
    for _ in 2..number {
        let next_number = last_number + last_last_number;
        last_last_number = last_number;
        last_number = next_number
    }
    last_number + last_last_number
}

const GIFTS_BY_DAY: [&str; 12] = [
    "partridge in a pear tree",
    "Two turtle doves",
    "Three French hens",
    "Four calling birds",
    "Five gold rings",
    "Six geese a laying",
    "Seven swans a swimming",
    "Eight maids a milking",
    "Nine ladies dancing",
    "Ten lords a leaping",
    "Eleven pipers piping",
    "Twelve drummers drumming",
];

const NTH_DAYS: [&str; 12] = [
    "first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "nineth", "tenth",
    "eleventh", "twelfth",
];

fn song_lyrics(num_days: usize) -> String {
    let mut lyrics = String::from("");
    for i in 0..num_days {
        lyrics.push_str(&format!(
            "On the {} day of Christmas\nMy true love gave to me\n{}\n\n",
            NTH_DAYS[i],
            nth_day_gift(i + 1, true)
        ));
    }
    return lyrics;
}

fn nth_day_gift(day: usize, first_call: bool) -> String {
    if day == 1 && first_call {
        return String::from("A ") + GIFTS_BY_DAY[0];
    } else if day == 1 {
        return String::from("And a ") + GIFTS_BY_DAY[0];
    } else {
        return String::from(GIFTS_BY_DAY[day - 1]) + "\n" + &nth_day_gift(day - 1, false);
    }
}
