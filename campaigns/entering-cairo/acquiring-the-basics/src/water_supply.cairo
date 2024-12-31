// Rule: No changing function signatures!

fn combine_water(volume_1: u32, volume_2: u128) -> u64 {
    // Convert and add the volumes, then cast to u64
    let result: u64 = volume_1.into() + volume_2.try_into().unwrap();
    result
}

fn is_prime(volume: u256) -> bool {
    // 0 and 1 are not prime numbers
    if volume <= 1 {
        return false;
    }

    // Check divisibility up to square root of volume
    let mut i: u256 = 2;
    let mut is_prime = true;
    
    while i * i <= volume {
        if volume % i == 0 {
            is_prime = false;
            break;
        }
        i += 1;
    };
    
    is_prime
}