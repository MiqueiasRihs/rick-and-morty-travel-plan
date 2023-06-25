require "kemal"
require "json"

require "../config/**"

require "./utils"
require "./api/utils"
require "./models/travels"

post "/travel_plans" do |env|
  data = env.params.json
  data = data["travel_stops"]

  result = [] of Int32
  if data.is_a?(Array(JSON::Any))
    data.each do |element|
      result << element.as_i
    end
  end

  travel = Travels.create({travel_stops: result})

  env.response.status_code = 200
  env.response.content_type = "application/json"
  response = {id: travel.id, travel_stops: travel.travel_stops}.to_json

end

get "/travel_plans" do |env|
  params = env.params.query
  travels = Travels.all.results

  optimize = params.has_key?("optimize") ? params["optimize"] : "false"
  expand = params.has_key?("expand") ? params["expand"] : "false"

  list_travels = [] of TravelsObj

  if travels
    travels.each do |travel|
      places_str = travel.travel_stops.to_s[1..-2].split(",")

      places = optimize_and_expand_query(places_str, optimize, expand)

      trip = TravelsObj.new(
        id = travel.id.to_s.to_i,
        travel_stops = places
      )

      list_travels << trip
    end
  end

  env.response.content_type = "application/json"
  env.response.status_code = 200
  response = list_travels.to_json
end

get "/travel_plans/:id" do |env|
  id = env.params.url["id"]
  params = env.params.query

  optimize = params.has_key?("optimize") ? params["optimize"] : "false"
  expand = params.has_key?("expand") ? params["expand"] : "false"

  travel = Travels.where { c("id") == id }.results
  if !travel.empty?
    travel_instance = travel.first
    places_str = travel_instance.travel_stops.to_s[1..-2].split(",")

    places = optimize_and_expand_query(places_str, optimize, expand)

    travel_parse = TravelsObj.new(
      id = travel_instance.id.to_s.to_i,
      travel_stops = places
    )
  else
    travel_parse = TravelsObj.new(nil, [] of Int32)
  end

  env.response.content_type = "application/json"
  env.response.status_code = !travel.empty? ? 200 : 404
  response = travel_parse.to_json
end

put "/travel_plans/:id" do |env|
  id = env.params.url["id"]
  data = env.params.json
  data = data["travel_stops"]

  result = [] of Int32
  if data.is_a?(Array(JSON::Any))
    data.each do |element|
      result << element.as_i
    end
  end

  Travels.where { c("id") == id }.update(travel_stops: result)
  treval_plan = Travels.where { c("id") == id }.results.first

  place_id = treval_plan.id.to_s.to_i
  places = treval_plan.travel_stops.to_s[1..-2].split(",").map { |s| s.to_i }

  trip = TravelsObj.new(
    id = place_id,
    travel_stops = places
  )

  env.response.content_type = "application/json"
  env.response.status_code = 200
  response = trip.to_json
end

put "/travel_plans/:id/append" do |env|
  id = env.params.url["id"]
  data = env.params.json
  data = data["travel_stops"]

  travel = Travels.where { c("id") == id }.results
  if !travel.empty?
    travel_plan = travel.first
    places = travel_plan.travel_stops.to_s[1..-2].split(",").map { |s| s.to_i }
    
    if data.is_a?(Array(JSON::Any))
      data.each do |element|
        if !places.includes?(element.as_i)
          places << element.as_i
        end
      end
    end

    Travels.where { c("id") == id }.update(travel_stops: places)

    travel_plan_result = TravelsObj.new(
      id = travel_plan.id.to_s.to_i,
      travel_stops = places
    )
  else
    travel_plan_result = TravelsObj.new(nil, [] of Int32)
  end

  env.response.content_type = "application/json"
  env.response.status_code = 200
  response = travel_plan_result.to_json
end

delete "/travel_plans/:id" do |env|
  id = env.params.url["id"]

  Travels.delete(id)

  env.response.content_type = "application/json"
  env.response.status_code = 204

end

get "/docs" do |env|
  env.response.content_type = "text/html"
  render "src/docs/v1/api-documentation.html"
end

require "./app"
Kemal.run
