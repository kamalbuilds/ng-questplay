fn give_directions(
    mut directions: Array<felt252>
) -> felt252 {
    // Create a dictionary to store direction counts
    let mut direction_counts: Felt252Dict<u32> = Default::default();
    
    // Keep track of the most frequent direction and its count
    let mut most_frequent_direction: felt252 = 0;
    let mut highest_count: u32 = 0;
    
    // Count occurrences of each direction
    loop {
        match directions.pop_front() {
            Option::Some(direction) => {
                // Get current count and increment it
                let current_count = direction_counts.get(direction);
                let new_count = current_count + 1;
                direction_counts.insert(direction, new_count);
                
                // Update most frequent if this count is higher
                if new_count > highest_count {
                    highest_count = new_count;
                    most_frequent_direction = direction;
                }
            },
            Option::None => {
                break;
            }
        };
    };
    
    most_frequent_direction
}