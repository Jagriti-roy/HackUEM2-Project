module CarbonCreditToken {
    use 0x1::Address;
    use 0x1::Signer;
    use 0x1::Vector;

    struct CarbonCredit {
        value: u64,
        owner: address,
    }

    public fun mint(creator: &signer, value: u64): CarbonCredit {
        let owner = Signer::address_of(creator);
        CarbonCredit { value, owner }
    }

    public fun transfer(token: &mut CarbonCredit, new_owner: address) {
        token.owner = new_owner;
    }

    public fun get_owner(token: &CarbonCredit): address {
        token.owner
    }

    public fun get_value(token: &CarbonCredit): u64 {
        token.value
    }
}