fn untangle_harness(
    mut ropes: Array<u256>,
    knot: u256
) -> Array<u256> {
    let mut sum: u256 = 0;
    let mut found = false;
    let mut result: Array<u256> = ArrayTrait::new();
    
    // Keep popping elements until we find the knot
    loop {
        match ropes.pop_front() {
            Option::Some(value) => {
                if value == knot {
                    // Found the knot, start building result array
                    result.append(value);
                    found = true;
                    break;
                }
                // Add the value to our sum
                sum += value;
            },
            Option::None => {
                break; // Array is empty
            }
        };
    };
    
    // Add remaining elements to result
    loop {
        match ropes.pop_front() {
            Option::Some(value) => {
                result.append(value);
            },
            Option::None => {
                break;
            }
        };
    };
    
    // Append the sum at the end
    result.append(sum);
    
    result
}