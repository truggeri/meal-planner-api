# meal-planner-api
Ruby based api for meal planner application.

![](https://github.com/truggeri/meal-planner-api/workflows/Build/badge.svg)

## Getting started

To run locally,
```bash
bundle install
bundle exec puma --config config/puma.rb
```

You can test that the server is working by hitting the health endpoint,

```bash
curl -D - -X GET --url http://localhost:4000/healthz
```

### Docker for local dependencies
If you want to use Docker to setup a Postgres database locally, you can do so via Rake task,

```bash
bundle exec rake docker:db:start
```

This will start a Postgres database using [env variables](#configuration) for the hosted port, database name, username and password. To tear this db down, run

```bash
bundle exec rake docker:db:stop
```

## Configuration

Environment variables used for configuration,

| Var | Default | Setting |
|---|---|---|
| MEAL_PLANNER_API_DB_HOST | localhost | Tcp address of the database |
| MEAL_PLANNER_API_DB_PORT | 15400 | Tcp port of the database |
| MEAL_PLANNER_API_DB_USERNAME | - | Postgres username |
| MEAL_PLANNER_API_DB_PASSWORD | - | Postgres password |
| DATABASE_URL | - | Postgres url (with username, password, host and port) - overwrites all above |
| SINATRA_ENV | development | Environment to run in |
| RACK_ENV | - | Environment to run Rack server in |
| PORT | 4000 | Port to host Rack server on |

## Running with Docker

There is a [Dockerfile](https://docs.docker.com/get-started/#build-and-test-your-image) for this project. To build it,

```bash
docker build --tag meal-planner-api .
```

Then to run via container,

```bash
docker run --rm --detatch --port 4000:4000 --name meal-planner-api meal-planner-api:latest
```

To set configuration options, use the `docker run` `--env` option to pass in environment variables as in the above [configuration section](#configuration).

## Testing

Tests are written using the [MiniTest framework](https://github.com/seattlerb/minitest). To run tests, 

```bash
bundle exec rake test
```

Linting is done by [Rubocop](https://github.com/rubocop-hq/rubocop) and can be run with,

```bash
bundle exec rubocop -D
```
