require "uri"
require "http/client"
require "http/request"

class RickAndMortyApiClient
  BASE_URL = "https://rickandmortyapi.com/graphql"

  def make_get_request(query : String)
    escaped_query = URI.encode_path(query)
    url = "#{BASE_URL}?query=#{escaped_query}"
    response = HTTP::Client.get(url)

    if response.status_code == 200
        response.body
    else
      nil
    end
  end
end
