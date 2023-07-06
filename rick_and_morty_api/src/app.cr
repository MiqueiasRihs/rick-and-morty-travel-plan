require "kemal"
require "json"

require "../config/**"

require "./utils"
require "./api/utils"
require "./models/travels"

get "/" do |env|
    client = RickAndMortyApiClient.new
    api_query = get_all_locations()
    api_request = JSON.parse(client.make_get_request(api_query).to_s)
    travels = api_request["data"]["locations"]["results"].as_a

    list_travels = [] of TravelStops
    travels.each do |travel|
      list_travels << TravelStops.new(
        id = travel["id"].to_s.to_i,
        name = travel["name"].to_s
      )

    end

    render "src/views/all_locations.ecr", "src/views/layouts/layout.ecr"
end
  
get "/editar_viagem/:id" do |env|
    id = env.params.url["id"]

    client = RickAndMortyApiClient.new
    api_query = get_all_locations()
    api_request = JSON.parse(client.make_get_request(api_query).to_s)
    list_travels = api_request["data"]["locations"]["results"].as_a

    travel_instance = Travels.where { c("id") == id }.results.first
    places_str = travel_instance.travel_stops.to_s[1..-2].split(",")

    places = optimize_and_expand_query(places_str, "false", "false")

    travel_parse = TravelsObj.new(
        id = travel_instance.id.to_s.to_i,
        travel_stops = places
    )

    render "src/views/edit_travel.ecr", "src/views/layouts/layout.ecr"
end

get "/meus_planos" do |env|
    params = env.params.query
    travels = Travels.all.results
  
    optimize = params.has_key?("optimize") ? params["optimize"] : "false"
    expand = params.has_key?("expand") ? params["expand"] : "false"
  
    list_travels = [] of TravelsObj
    if travels
      travels.each do |travel|
        places_str = travel.travel_stops.to_s[1..-2].split(",")
  
        places = optimize_and_expand_query(places_str, optimize, expand)
  
        list_travels << TravelsObj.new(
          id = travel.id.to_s.to_i,
          travel_stops = places
        )
  
      end
    end
  
    render "src/views/saved_locations.ecr", "src/views/layouts/layout.ecr"
end