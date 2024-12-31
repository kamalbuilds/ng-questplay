fn ration_food(n: u32) -> u128 {
    // Skip eating every 5th day starting from day 4
    if (n + 1) % 5 == 0 {
        return 0;
    }
    
    // For other days, follow Fibonacci sequence
    if n == 0 {
        return 0;
    }
    if n == 1 || n == 2 {
        return 1;
    }
    
    let mut prev: u128 = 1;
    let mut curr: u128 = 1;
    let mut i: u32 = 3;
    
    while i <= n {
        let next = prev + curr;
        prev = curr;
        curr = next;
        i += 1;
    };
    
    curr
}
