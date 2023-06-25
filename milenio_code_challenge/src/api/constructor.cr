require "./utils"

class RickAndMortyConstructors
    CLIENT = RickAndMortyApiClient.new
  
    def expand_location_response(places_str)
        api_query = get_locations_details_query(places_str)
        api_request = JSON.parse(CLIENT.make_get_request(api_query).to_s)
        
        location_list = [] of TravelStops
        locations = api_request["data"]["locationsByIds"].as_a
        
        locations.each do |location|
            location_list << TravelStops.new(
                id = location["id"].to_s.to_i,
                name = location["name"].to_s,
                type = location["type"].to_s,
                dimension = location["dimension"].to_s
            )
        end

        return location_list
    end

    def optimize_location_response(places_str, expand)
        api_query = optimize_locations_query(places_str)
        api_request = JSON.parse(CLIENT.make_get_request(api_query).to_s)
        locations = api_request["data"]["locationsByIds"].as_a

        sort_locations = sort_locations(locations, expand)

        return sort_locations
    end

    def get_all_locations()
        api_query = get_all_locations()
        api_request = JSON.parse(CLIENT.make_get_request(api_query).to_s)
        locations = api_request["data"]["locationsByIds"].as_a

        sort_locations = sort_locations(locations, expand)

        return sort_locations
    end
end