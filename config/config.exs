# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_activity, ecto_repos: [ExActivity.Repo]

config :ex_activity, ExActivity.Repo,
  adapter: Application.get_env(:ex_activity, :adapter, nil),
  username: Application.get_env(:ex_activity, :username, ""),
  password: Application.get_env(:ex_activity, :password, ""),
  database: Application.get_env(:ex_activity, :database, ""),
  hostname: Application.get_env(:ex_activity, :hostname, "localhost"),
  charset: Application.get_env(:ex_activity, :charset, "utf8mb4"),
  pool_size: 10

import_config "#{Mix.env}.exs"
