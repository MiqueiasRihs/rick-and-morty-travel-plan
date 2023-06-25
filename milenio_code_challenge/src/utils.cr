require "json_mapping"

class TravelsObj
    JSON.mapping(
      id: Int32 | Nil,
      travel_stops: Array(TravelStops) | Array(Int32),
    )
  
    def initialize(id : Int32 | Nil, travel_stops : Array(TravelStops) | Array(Int32))
      @id = id
      @travel_stops = travel_stops
    end
end

class TravelStops
  JSON.mapping(
    id: Int32,
    name: String,
    type: String?,
    dimension: String?,
    image: String?
  )

  def initialize(id : Int32, name : String, type : String? = nil, dimension : String? = nil, image : String? = nil)
    @id = id
    @name = name
    @type = type
    @dimension = dimension
    @image = image
  end
end