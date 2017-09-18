use Mix.Config

config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "jackjoe",
  password: "",
  database: "ex_activity-test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
