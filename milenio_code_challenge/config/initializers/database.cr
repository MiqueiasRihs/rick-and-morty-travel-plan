require "jennifer"
require "jennifer/adapter/postgres" # for PostgreSQL

# Jennifer::Config.read("config/database.yml", :development)

APP_ENV = ENV["APP_ENV"]? || "development"
# 
Jennifer::Config.configure do |conf|
  conf.read("config/database.yml", APP_ENV)
  conf.from_uri(ENV["localhost:5432/milenio"]) if ENV.has_key?("localhost:5432/milenio")
  conf.logger.level == "development" ? :debug : :error
  conf.pool_size = 20
  conf.max_pool_size = 20
end

# Jennifer::Config.reset_config
# Jennifer::Config.configure do |conf|
#   conf.host = "localhost"
#   conf.user = "postgres"
#   conf.password = ""
#   conf.adapter = "postgres"
#   conf.db = "milenio"
#   conf.migration_files_path = "./any/path/migrations"
#   conf.pool_size = (ENV["DB_CONNECTION_POOL"]? || 15).to_i
# end

