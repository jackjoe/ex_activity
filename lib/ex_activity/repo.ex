defmodule ExActivity.Repo do
  @moduledoc """
  Ecto repo
  """
  # use Ecto.Repo, otp_app: :ex_activity
  def init(_, config) do
    config = Keyword.put(config, :url, System.get_env("DATABASE_URL"))
    config = Keyword.put(config, :adapter, Application.get_env(:ex_activity, :adapter, Ecto.Adapters.MySQL))
    config = Keyword.put(config, :username, Application.get_env(:ex_activity, :username, ""))
    config = Keyword.put(config, :password, Application.get_env(:ex_activity, :password, ""))
    config = Keyword.put(config, :database, Application.get_env(:ex_activity, :database, ""))
    config = Keyword.put(config, :hostname, Application.get_env(:ex_activity, :hostname, "localhost"))
    config = Keyword.put(config, :charset, Application.get_env(:ex_activity, :charset, "utf8mb4"))
    {:ok, config}
  end
end
