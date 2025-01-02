// RULE: Do not modify this enum!
#[derive(Drop, PartialEq)]
enum Demon {
    Bush,
    Cactus: u256,
    Tree: Array<u256>
}

#[generate_trait]
impl DemonImpl of DemonTrait {
    // Returns true if `self` is evil:
    //  * Bush demons are never evil.
    //  * Cactus demons are evil if their inner `u256` is a cube number greater than 1.
    //  * Tree demons are evil if their inner `Array<u256>` only have integers of the same parity.
    fn is_evil(self: @Demon) -> bool {
        match self {
            Demon::Bush => false,
            Demon::Cactus(inner) => {
                // Check if inner is a cube number greater than 1
                let mut i: u256 = 1;
                loop {
                    if i * i * i > *inner {
                        break false;
                    }
                    if i * i * i == *inner {
                        break *inner > 1;
                    }
                    i += 1;
                }
            },
            Demon::Tree(inner) => {
                // Check if array elements have same parity
                if inner.len() == 0 {
                    true
                } else {
                    let first_parity = *inner.at(0) % 2;
                    let mut i: usize = 1;
                    loop {
                        if i >= inner.len() {
                            break true;
                        }
                        if *inner.at(i) % 2 != first_parity {
                            break false;
                        }
                        i += 1;
                    }
                }
            }
        }
    }

    // Modify the given demon:
    //  * Bush demons are unchanged.
    //  * Cactus demons have their inner `u256` set to 0.
    //  * Tree demons have all elements in their inner `Array<u256>` set to `0`.
    fn cleanse(ref self: Demon) {
        self = match self {
            Demon::Bush => Demon::Bush,
            Demon::Cactus(_) => Demon::Cactus(0),
            Demon::Tree(inner) => {
                let mut new_array = ArrayTrait::new();
                let mut i: usize = 0;
                loop {
                    if i >= inner.len() {
                        break;
                    }
                    new_array.append(0);
                    i += 1;
                };
                Demon::Tree(new_array)
            },
        };
    }
}