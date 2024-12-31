fn ration_food(n: u32) -> u128 {
    // Special cases for multiples of 4 and 9
    if n % 4 == 0 || n % 9 == 0 {
        return 0;
    }
    
    // For other numbers, calculate Fibonacci
    if n == 0 {
        return 0;
    }
    if n == 1 {
        return 1;
    }
    
    let mut prev: u128 = 0;
    let mut curr: u128 = 1;
    let mut i: u32 = 2;
    
    while i <= n {
        let next = prev + curr;
        prev = curr;
        curr = next;
        i += 1;
    };
    
    curr
}