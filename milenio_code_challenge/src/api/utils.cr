require "../graphql/schemas"
require "../api/rick_and_morty_api"
require "../utils"
require "./constructor"

def sort_locations(locations : Array(JSON::Any), expand : String)
    # Sort locations based on specific criteria
    sorted_locations = locations.sort do |a, b|
        # Sort by dimension (string comparison)
        result = a["dimension"].to_s <=> b["dimension"].to_s
        if result.zero?
            # Sort by number of residents (array size comparison)
            result = a["residents"].size <=> b["residents"].size
            if result.zero?
                # Sort by name (string comparison)
                result = a["name"].to_s <=> b["name"].to_s
                if result.zero?
                    # Sort by ID (integer comparison)
                    result = a["id"].to_s.to_i <=> b["id"].to_s.to_i
                end
            end
        end
        result
    end

    # Create an array of TravelStops objects
    travel_stops = [] of TravelStops
    sorted_locations.each do |loc|
        travel_stops << TravelStops.new(
            id = loc["id"].to_s.to_i,
            name = loc["name"].to_s,
            type = loc["type"].to_s,
            dimension = loc["dimension"].to_s
        )
    end

    if expand == "false"
        # Return an array of sorted location IDs
        return sorted_locations.map { |location| location["id"].to_s.to_i }
    end

    return travel_stops
end

def optimize_and_expand_query(locations_ids : Array(String), optimize, expand)
    constructor = RickAndMortyConstructors.new

    
    if expand == "true" && optimize == "false"
        places = constructor.expand_location_response(locations_ids)
    elsif optimize == "true"
        places = constructor.optimize_location_response(locations_ids, expand)
    else
        places = locations_ids.map { |s| s.to_i }
    end

    return places
end
