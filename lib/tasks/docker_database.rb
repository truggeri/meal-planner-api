namespace :docker do
  namespace :db do
    desc "Starts a dev database using docker"
    task :start do
      database_port = ENV["MEAL_PLANNER_API_DB_PORT"].to_i.presence || 15_400
      # rubocop:disable Metrics/LineLength
      `docker run --name meal_planner_api_db --detach --publish #{database_port}:5432 -e POSTGRES_DB=$MEAL_PLANNER_API_DB_DATABASE -e POSTGRES_USER=$MEAL_PLANNER_API_DB_USERNAME -e POSTGRES_PASSWORD=$MEAL_PLANNER_API_DB_PASSWORD postgres:11.4`
      # rubocop:enable Metrics/LineLength
    end

    desc "Stops a dev database using docker"
    task :stop do
      `docker stop meal_planner_api_db`
      `docker rm meal_planner_api_db`
    end
  end
end
