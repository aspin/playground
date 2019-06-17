use std::collections::HashMap;

fn main() {

    assert_eq!(median(&vec![1, 4, 3]), 3.0);
    assert_eq!(median(&vec![1, 4, 3, 9]), 3.5);
    assert_eq!(median(&vec![1, 10, 20, 2, 98]), 10.0);

    assert_eq!(mode(&vec![1, 4, 3, 4]), [4]);
    assert!(mode(&vec![4, 4, 3, 3, 5, 4, 3]).contains(&4));
    assert!(mode(&vec![4, 4, 3, 3, 5, 4, 3]).contains(&3));
}

fn median(v: &Vec<i32>) -> f32 {
    let mut sorted_vector = v.to_vec();
    sorted_vector.sort();
    if sorted_vector.len() % 2 == 1 {
        sorted_vector[sorted_vector.len() / 2] as f32
    } else {
        (sorted_vector[sorted_vector.len() / 2] + sorted_vector[sorted_vector.len() / 2 - 1]) as f32 / 2.0 
    }
}

fn mode(v: &Vec<i32>) -> Vec<i32> {
    let mut frequency: HashMap<i32, i32> = HashMap::new();
    for i in v {
        *frequency.entry(*i).or_insert(0) += 1
    }

    let mut modes = Vec::new();
    let mut max_counts = 0;
    for (key, value) in frequency {
        if value > max_counts {
            max_counts = value;
            modes.clear();
            modes.push(key);
        } else if value == max_counts {
            modes.push(key);
        }
    }

    return modes;
}
