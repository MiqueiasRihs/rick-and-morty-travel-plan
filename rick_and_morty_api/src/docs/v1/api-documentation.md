# Documentation for Rick and Morty API

The following document describes the API methods available for the system.

## POST /travel_plans

This method receives a JSON object containing an array of integers called "travel_stops". It creates a new travel plan with this array and returns the ID of the new travel plan.

### Request

- URL: /travel_plans
- Method: POST
- Headers: none
- Body: JSON object with the following structure:

```
{
  "travel_stops": [1,2,3,4,5]
}

```

### Response

- Headers: Content-Type: application/json
- Body: JSON object with the following structure:

```
{
  "id": 1,
  "travel_stops": [1,2,3,4,5]
}

```

## GET /travel_plans

This method returns a list of all travel plans stored in the system. It also receives two optional parameters called "optimize" and "expand" that are used to optimize the response.

### Request

- URL: /travel_plans
- Method: GET
- Headers: none
- Query Parameters:
    - optimize: (optional) "true" or "false". Default is "false". When receiving this parameter, the API should return the travel_stops array reordered to minimize the number of interdimensional jumps and organize the travel stops going from the least popular to the most popular locations. To do so, all locations in the same dimension must be visited before jumping to a location in another dimension. Within the same dimension, locations must be visited in increasing order of popularity, and in case of a tie, in alphabetical order of name. The popularity of a location is calculated by summing the number of episodes in which each resident of that location appeared. To define the order of visit for dimensions, the average popularity of their locations must be used. In case of a tie in average popularity, dimensions must be sorted alphabetically.
    - expand: (optional) "true" or "false". Default is "false".

### Response

- Headers: Content-Type: application/json
- Body: JSON object with the following structure:

```
[
  {
    "id": 1,
    "travel_stops": [1,2,3,4,5]
  },
  {
    "id": 2,
    "travel_stops": [1,2,3,4,5,6,7,8,9,10]
  }
]

```

## GET /travel_plans/:id

This method returns a specific travel plan based on its ID. It also receives two optional parameters called "optimize" and "expand" that are used to optimize the response.

### Request

- URL: /travel_plans/{id}
- Method: GET
- Headers: none
- Query Parameters:
    - optimize: (optional) "true" or "false". Default is "false". When receiving this parameter, the API should return the travel_stops array reordered to minimize the number of interdimensional jumps and organize the travel stops going from the least popular to the most popular locations. To do so, all locations in the same dimension must be visited before jumping to a location in another dimension. Within the same dimension, locations must be visited in increasing order of popularity, and in case of a tie, in alphabetical order of name. The popularity of a location is calculated by summing the number of episodes in which each resident of that location appeared. To define the order of visit for dimensions, the average popularity of their locations must be used. In case of a tie in average popularity, dimensions must be sorted alphabetically.
    - expand: (optional) "true" or "false". Default is "false".

### Response

- Headers: Content-Type: application/json
- Body: JSON object with the following structure:

```
{
  "id": 1,
  "travel_stops": [1,2,3,4,5]
}

```

## PUT /travel_plans/:id

This method updates a specific travel plan based on its ID. It receives a JSON object containing an array of integers called "travel_stops".

### Request

- URL: /travel_plans/{id}
- Method: PUT
- Headers: none
- Body: JSON object with the following structure:

```
{
  "travel_stops": [1,2,3,4,5]
}

```

### Response

- Headers: Content-Type: application/json
- Body: JSON object with the following structure:

```
{
  "id": 1,
  "travel_stops": [1,2,3,4,5]
}

```

## PUT /travel_plans/:id/append

This method appends a list of stops to a specific travel plan based on its ID. It receives a JSON object containing an array of integers called "travel_stops".

### Request

- URL: /travel_plans/{id}/append
- Method: PUT
- Headers: none
- Body: JSON object with the following structure:

```
{
  "travel_stops": [6,7,8,9,10]
}

```

### Response

- Headers: Content-Type: application/json
- Body: JSON object with the following structure:

```
{
  "id": 1,
  "travel_stops": [1,2,3,4,5,6,7,8,9,10]
}

```

## DELETE /travel_plans/:id

This method deletes a specific travel plan based on its ID.

### Request

- URL: /travel_plans/{id}
- Method: DELETE
- Headers: none

### Response

- Headers: Content-Type: application/json
- Body: none