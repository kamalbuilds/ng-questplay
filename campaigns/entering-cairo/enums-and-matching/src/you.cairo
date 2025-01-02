use src::demon::{Demon, DemonTrait};

// RULE: Do not modify this struct!
#[derive(Drop)]
struct You {
    equipped_spell: Option<felt252>,
    cleanse_count: u32
}

#[generate_trait]
impl YouImpl of YouTrait {
    // Fix equip_spell to always set the spell
    fn equip_spell(ref self: You, spell: felt252) {
        self.equipped_spell = Option::Some(spell);
    }

    // Modifies `demons` depending on the equipped spell.
    fn cleanse(ref self: You, ref demons: Array<Demon>) {
        match self.equipped_spell {
            Option::None => {},
            Option::Some(spell) => {
                let mut new_demons = ArrayTrait::new();
                let mut i: usize = 0;
                let mut cleansed_count: u32 = 0;

                loop {
                    if i >= demons.len() {
                        break;
                    }
                    let demon = demons.at(i);
                    if spell == 'Cleanse All'
                        || (spell == 'Cleanse Evil' && DemonTrait::is_evil(demon)) {
                        cleansed_count += 1;
                        // When cleansing, create new "clean" versions
                        match demon {
                            Demon::Bush => new_demons.append(Demon::Bush),
                            Demon::Cactus(_) => new_demons.append(Demon::Cactus(0)),
                            Demon::Tree(x) => {
                                let mut clean_array = ArrayTrait::new();
                                let mut j = 0;
                                loop {
                                    if j >= x.len() {
                                        break;
                                    }
                                    clean_array.append(0);
                                    j += 1;
                                };
                                new_demons.append(Demon::Tree(clean_array));
                            },
                        }
                    } else {
                        // When not cleansing, recreate the original demon
                        match demon {
                            Demon::Bush => new_demons.append(Demon::Bush),
                            Demon::Cactus(x) => new_demons.append(Demon::Cactus(*x)),
                            Demon::Tree(x) => new_demons.append(Demon::Tree(x.clone())),
                        }
                    }
                    i += 1;
                };

                if cleansed_count > 0 {
                    self.cleanse_count += cleansed_count;
                }
                demons = new_demons;
                self.equipped_spell = Option::None;
            }
        }
    }
}