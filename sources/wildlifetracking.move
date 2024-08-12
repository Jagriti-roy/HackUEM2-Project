module WildlifeTracking {
    use 0x1::Address;
    use 0x1::Signer;
    use 0x1::Vector;
    use 0x1::Option;
    use 0x1::Debug;

    struct WildlifeData {
        species: string,
        location: string,
        timestamp: u64,
    }

    struct TrackingPlatform {
        data_records: Vector::Vector<WildlifeData>,
    }

    public fun new_platform(): TrackingPlatform {
        TrackingPlatform {
            data_records: Vector::empty<WildlifeData>(),
        }
    }

    public fun record_data(platform: &mut TrackingPlatform, species: string, location: string, timestamp: u64) {
        let data = WildlifeData {
            species,
            location,
            timestamp,
        };
        Vector::push_back(&mut platform.data_records, data);
    }

    public fun get_data(platform: &TrackingPlatform): Vector::Vector<WildlifeData> {
        Vector::clone(&platform.data_records)
    }
}