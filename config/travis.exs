use Mix.Config

config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "ex_activity_test",
  hostname: "127.0.0.1",
  pool: Ecto.Adapters.SQL.Sandbox
