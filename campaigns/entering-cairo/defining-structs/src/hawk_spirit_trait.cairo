use src::hawk_spirit::HawkSpirit;

// RULE: Do not modify trait!
trait HawkSpiritTrait {
    // Return a new `HawkSpirit` with same speed and new position:
    //   * new_position = position + speed
    fn fly(self: @HawkSpirit) -> HawkSpirit;

    // Returns true if hawk spirit is at an oasis:
    //   * At position `x` and `oasis_map[x] == true`
    fn is_at_oasis(self: @HawkSpirit, oasis_map: @Array<bool>) -> bool;
}

impl HawkSpiritImpl of HawkSpiritTrait {
    fn fly(self: @HawkSpirit) -> HawkSpirit {
        HawkSpirit { position: *self.position + *self.speed, speed: *self.speed }
    }

    fn is_at_oasis(self: @HawkSpirit, oasis_map: @Array<bool>) -> bool {
        let pos = *self.position;
        if pos < oasis_map.len() {
            *oasis_map.at(pos)
        } else {
            false
        }
    }
}

// Repeatedly call `fly` for every hawk, until one hawk reaches an oasis.
// Returns the index of the first oasis found.
// You can assume that at least one hawk will eventually reach an oasis.
fn find_oasis(hawks: Array<HawkSpirit>, oasis_map: @Array<bool>) -> u32 {
    let mut hawks = hawks;
    let mut i: u32 = 0;
    loop {
        if i >= hawks.len() {
            i = 0;
            continue;
        }
        let hawk = hawks.at(i);
        if hawk.is_at_oasis(oasis_map) {
            break *hawk.position;
        }
        hawks.append(hawk.fly());
        i += 1;
    }
}