namespace :docker do
  namespace :db do
    desc "Starts a dev database using docker"
    task :start do
      database_port = ENV["MEAL_PLANNER_API_DB_PORT"].to_i.presence || 15_400
      work_dir = `pwd`.chomp
      `mkdir -p #{work_dir}/data/db`

      docker_cmd_options = []
      docker_cmd_options << "--name meal_planner_api_db"
      docker_cmd_options << "--detach"
      docker_cmd_options << "--publish #{database_port}:5432"
      docker_cmd_options << "--volume #{work_dir}/data/db:/var/lib/postgresql/data"
      docker_cmd_options << "--env POSTGRES_DB=$MEAL_PLANNER_API_DB_DATABASE"
      docker_cmd_options << "--env POSTGRES_USER=$MEAL_PLANNER_API_DB_USERNAME"
      docker_cmd_options << "--env POSTGRES_PASSWORD=$MEAL_PLANNER_API_DB_PASSWORD"

      system("docker run #{docker_cmd_options.join(' ')} postgres:11.5")
    end

    desc "Stops a dev database using docker"
    task :stop do
      `docker stop meal_planner_api_db`
      `docker rm meal_planner_api_db`
    end
  end
end
