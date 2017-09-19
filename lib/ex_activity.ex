defmodule ExActivity do
  alias ExActivity.{Activity, Log}

  @moduledoc """
  Enables to log activity in a structured way to a MySQL database.

  The `log` functions accepts a `ExActivity.Log` struct which is then saved to the database.

  Log like so:
      ExActivity.log(%ExActivity.Log{type: "error", action: "saveUser", result: "invalid_email"})
  """

  @doc false

  # ip / user_agent from conn
  @spec log(Log.t) :: Activity.t
  def log(%Log{} = log) do
    IO.puts(">>")
    IO.inspect(Application.get_env(:ex_activity, :username))
    IO.puts(">>")
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
