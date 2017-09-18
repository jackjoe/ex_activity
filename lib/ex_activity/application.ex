defmodule ExActivity.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

config = []

config = Keyword.put(config, :url, System.get_env("DATABASE_URL"))
config = Keyword.put(config, :adapter, Ecto.Adapters.MySQL)
config = Keyword.put(config, :username, Application.get_env(:ex_activity, :username, ""))
config = Keyword.put(config, :password, Application.get_env(:ex_activity, :password, ""))
config = Keyword.put(config, :database, Application.get_env(:ex_activity, :database, ""))
config = Keyword.put(config, :hostname, Application.get_env(:ex_activity, :hostname, "localhost"))
config = Keyword.put(config, :charset, Application.get_env(:ex_activity, :charset, "utf8mb4"))

    children = [
      supervisor(ExActivity.Repo, [config]),
    ]

    opts = [strategy: :one_for_one, name: ExActivity.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
