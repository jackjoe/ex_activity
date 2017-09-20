# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :ex_activity,
  ecto_repos: [ExActivity.Repo]

config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL

import_config "#{Mix.env}.exs"
