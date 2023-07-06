require "spec"
require "spec-kemal"
require "../src/rick_and_morty_api"

Spec.before_each do
    config = Kemal.config
    config.env = "test"
    config.setup
end
  
Spec.after_each do
    Kemal.config.clear
end


def create_travel()
    travel = Travels.create({travel_stops: [4, 5, 6]})
end

def get_all_travels_plan(optimize, expand)
    list_travels = [] of TravelsObj

    travels = Travels.all.results
    travels.each do |travel|
        places_str = travel.travel_stops.to_s[1..-2].split(",")
        places = optimize_and_expand_query(places_str, optimize, expand)

        list_travels << TravelsObj.new(
            id = travel.id.to_s.to_i,
            travel_stops = places
        )
    end

    return list_travels
end

def get_last_travel_plan(optimize, expand)
    travel = Travels.all.results.last

    places_str = travel.travel_stops.to_s[1..-2].split(",")
    places = optimize_and_expand_query(places_str, optimize, expand)

    trip = TravelsObj.new(
        id = travel.id.to_s.to_i,
        travel_stops = places
    )

    return trip
end

def clear_data_base()
    Travels.delete()

    result = Travels.all.results
end