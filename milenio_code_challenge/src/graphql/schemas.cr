def get_locations_details_query(ids)
    locations_details = %{
        query {
            locationsByIds(ids: #{ids}) {
                id,
                name,
                type,
                dimension
            }
        }
    }
    
    return locations_details
end

def optimize_locations_query(ids)
    optimize_locations = %{
        query {
            locationsByIds(ids: #{ids}) {
                id,
                name,
                type,
                dimension,
                residents {
                  episode {
                    id
                  }
                }
                
            }
        }
    }

    return optimize_locations
end

def get_all_locations()
    all_locations = %{
        query {
            locations {
                results {
                    id,
                    name
                }
            }
        }
    }
end