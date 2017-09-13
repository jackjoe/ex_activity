defmodule ExActivity do
  use Application
  alias ExActivity.{Activity, Log}

  @moduledoc """
  Enables to log activity in a structured way to a MySQL database

  ## Configuration
  Add the following to your production config
    config :ex_activity, ecto_repos: [ExActivity.Repo]
  """

  @doc false
  def start(_type, _args) do
    Supervisor.start_link(__MODULE__, [], name: :ex_activity)
  end

  # TODO ip / user_agent from conn
  @spec log(Log.t) :: Activity.t
  def log(%Log{} = log) do
    attrs = Map.from_struct(log)
    # Fill up
    # TODO
    attrs = attrs
      |> Map.merge(%{ip: ""})
      |> Map.merge(%{user_agent: ""})
    # Allow integers
    attrs = (case Map.has_key?(attrs, :details) && is_integer(attrs.details) do
        true ->
          attrs
          |> Map.put(:details, Integer.to_string(attrs.details))

        _ ->
          attrs
      end)
    # Need to convert to json string before insert, drop for now
    # TODO
    attrs = (case Map.has_key?(attrs, :data) && is_binary(attrs.data) do
        true ->
          attrs

        false ->
          attrs
          |> Map.drop([:data])
      end)
    # attrs |> Map.get_and_update(:data, fn current_value ->
    #   to_string(Poison.Encoder.encode(current_value, []))
    # end)

    Activity.log(attrs)
  end
end