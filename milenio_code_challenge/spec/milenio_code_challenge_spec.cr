require "./spec_helper"
require "http/client"

describe "MilenioCodeChallenge" do
  
  it "Empty database" do
    Travels.all.delete()
    
    get("/travel_plans")

    response.body.to_s.should eq "[]"
  end

  it "Creates a travel plan" do
    json_body = %({"travel_stops":[1,2,3]})
    post("/travel_plans", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: json_body)
    
    response.status_code.should eq 200
  end

  it "Get a travel plan" do
    travel = get_last_travel_plan("false", "false")

    get("/travel_plans/#{travel.id}")

    response.status_code.should eq 200
    response.body.to_s.should eq travel.to_json 
  end

  it "Get a travel plan with optime true" do
    travel = get_last_travel_plan("true", "false")

    get("/travel_plans/#{travel.id}?optimize=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travel.to_json 
  end

  it "Get a travel plan with expand true" do
    travel = get_last_travel_plan("false", "true")

    get("/travel_plans/#{travel.id}?expand=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travel.to_json 
  end

  it "Get a travel plan with optime and expand true" do
    travel = get_last_travel_plan("true", "true")

    get("/travel_plans/#{travel.id}?optimize=true&expand=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travel.to_json 
  end

  it "Get all travels plan" do
    create_travel()
    travels = get_all_travels_plan("false", "false")

    get("/travel_plans")

    response.status_code.should eq 200
    response.body.to_s.should eq travels.to_json
  end

  it "Get all travels plan with expand true" do
    create_travel()
    travels = get_all_travels_plan("false", "true")

    get("/travel_plans?expand=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travels.to_json
  end

  it "Get all travels plan with optimize true" do
    create_travel()
    travels = get_all_travels_plan("true", "false")

    get("/travel_plans?optimize=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travels.to_json
  end

  it "Get all travels plan with optimize and expand true" do
    create_travel()
    travels = get_all_travels_plan("true", "true")

    get("/travel_plans?optimize=true&expand=true")

    response.status_code.should eq 200
    response.body.to_s.should eq travels.to_json
  end

  it "Update travel plan" do
    travel = get_last_travel_plan("false", "false")

    json_body = %({"travel_stops":[10,11,12]})
    put("/travel_plans/#{travel.id}", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: json_body)

    result_travel = Travels.where { c("id") == travel.id }.results.first
    places_str = result_travel.travel_stops.to_s[1..-2].split(",")
    places = optimize_and_expand_query(places_str, "false", "false")

    trip = TravelsObj.new(
      id = result_travel.id.to_s.to_i,
      travel_stops = places
    )

    response.status_code.should eq 200
    response.body.to_s.should eq trip.to_json
  end

  it "Update travel plan append" do
    travel = get_last_travel_plan("false", "false")

    json_body = %({"travel_stops":[13,14,15]})
    put("/travel_plans/#{travel.id}/append", headers: HTTP::Headers{"Content-Type" => "application/json"}, body: json_body)

    result_travel = Travels.where { c("id") == travel.id }.results.first
    places_str = result_travel.travel_stops.to_s[1..-2].split(",")
    places = optimize_and_expand_query(places_str, "false", "false")

    trip = TravelsObj.new(
      id = result_travel.id.to_s.to_i,
      travel_stops = places
    )

    response.status_code.should eq 200
    response.body.to_s.should eq trip.to_json
  end

  it "Delete travel plan" do
    travel = get_last_travel_plan("false", "false")
    
    delete("/travel_plans/#{travel.id}")

    result = Travels.where { c("id") == travel.id }.results

    result.empty?.should be_true
    response.status_code.should eq 204
  end

end
