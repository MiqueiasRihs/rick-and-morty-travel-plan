class Travels < Jennifer::Model::Base
  with_timestamps

  mapping(
    id: Primary64,
    travel_stops: Array(Int32),
    created_at: Time?,
    updated_at: Time?,
  )
end
