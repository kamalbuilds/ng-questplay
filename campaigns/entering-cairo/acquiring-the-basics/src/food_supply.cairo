fn ration_food(n: u32) -> u128 {
    // Special cases for multiples of 4 and 9
    if n % 4 == 0 || n % 9 == 0 {
        return 0;
    }
    
    // For other numbers, calculate Fibonacci
    if n == 0 {
        return 0;
    }
    if n == 1 || n == 2 {
        return 1;
    }
    
    let mut a: u128 = 1;
    let mut b: u128 = 1;
    let mut i: u32 = 3;
    
    while i <= n {
        let temp = a + b;
        a = b;
        b = temp;
        i += 1;
    }
    
    b
}