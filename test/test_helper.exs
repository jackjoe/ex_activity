Mix.Task.run "ecto.create"
Mix.Task.run "ecto.migrate"

config = []

config = Keyword.put(config, :url, System.get_env("DATABASE_URL"))
config = Keyword.put(config, :adapter, Ecto.Adapters.MySQL)
config = Keyword.put(config, :username, Application.get_env(:ex_activity, :username, ""))
config = Keyword.put(config, :password, Application.get_env(:ex_activity, :password, ""))
config = Keyword.put(config, :database, Application.get_env(:ex_activity, :database, ""))
config = Keyword.put(config, :hostname, Application.get_env(:ex_activity, :hostname, "localhost"))
config = Keyword.put(config, :charset, Application.get_env(:ex_activity, :charset, "utf8mb4"))

ExActivity.Repo.start_link(config)
Ecto.Adapters.SQL.Sandbox.mode(ExActivity.Repo, {:shared, self()})

ExUnit.start()
