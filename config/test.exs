use Mix.Config

config :ex_activity, ExActivity.Repo,
  username: "jackjoe",
  password: "",
  database: "ex_activity-test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
