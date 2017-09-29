use Mix.Config

config :ex_activity, ExActivity.Repo,
  adapter: Ecto.Adapters.MySQL,
  database: "ex_activity_test",
  username: "root",
  password: "",
  hostname: "127.0.0.1"
