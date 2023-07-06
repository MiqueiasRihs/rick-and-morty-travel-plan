# Rick and Morty Travel Plans

This project is an API that manages interdimensional travel plans in the Rick and Morty universe. It is developed using the following tools: Crystal, Kemal, ORM Jennifer, GraphQL, and Docker. The API implements HTTP methods to create, view, update, and delete travel plans, as well as to optimize and expand the response of these operations.

## Available Methods

### POST /travel_plans

This method receives a JSON object containing an array of integers called "travel_stops". It creates a new travel plan with this array and returns the ID of the new travel plan.

### GET /travel_plans

This method returns a list of all the travel plans stored in the system. It also accepts two optional parameters called "optimize" and "expand" that are used to optimize and expand the response.

### GET /travel_plans/:id

This method returns a specific travel plan based on its ID. It also accepts two optional parameters called "optimize" and "expand" that are used to optimize and expand the response.

### PUT /travel_plans/:id

This method updates a specific travel plan based on its ID. It receives a JSON object containing an array of integers called "travel_stops".

### PUT /travel_plans/:id/append

This method appends a list of stops to a specific travel plan based on its ID. It receives a JSON object containing an array of integers called "travel_stops".

### DELETE /travel_plans/:id

This method deletes a specific travel plan based on its ID.

## Optional Parameters

The following optional parameters can be included in GET requests that receive a travel plan ID:

### optimize

When received, the API should return the "travel_stops" array reordered to minimize the number of interdimensional jumps and organize the travel stops from least popular to most popular locations. To do this, all locations in the same dimension must be visited before jumping to a location in another dimension. Within the same dimension, locations should be visited in ascending order of popularity, and in case of a tie, in alphabetical order of name. The popularity of a location is calculated by summing the number of episodes in which each resident of that location appeared.

### expand

When received, the API should return full details about the travel stops, including information about each visited location.

## Front-End

There is a simple front-end for this application at the root route. It was built using HTML, CSS, Bootstrap, and JavaScript. I also tried to fetch the images from the Fandom website, but for some reason, the images there were not being rendered in my HTML. Without them, it became more complex to fetch the images of the locations, but I believe the front-end looks nice and beautiful.

## Complete Documentation

The complete documentation of the API, including examples of requests and responses for each method, can be found in the file src/docs/v1/api-documentation.md in this repository and also at the address [/docs](localhos:3000/docs).

## Running the Project

To run the project, follow the steps below:

1. Clone this repository to your local machine.
2. With Docker installed, run the command `docker-compose up`.

The server will be available at [http://localhost:3000](http://localhost:3000/).

## Testing the Project

To test the project, follow the steps below:

1. In the root of the Kemal project, run the command `KEMAL_ENV=test crystal spec`.

The unit and integration tests will be executed, and the results will be displayed in the console.
