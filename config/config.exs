# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_activity,
  ecto_repos: [ExActivity.Repo]

config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL
#   username: "jackjoe",
#   password: "",
#   database: "gemeentet-dev",
#   hostname: "localhost",
#   charset: "utf8mb4",
#   pool_size: 10

import_config "#{Mix.env}.exs"
