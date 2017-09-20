defmodule ExActivity do
  alias ExActivity.{Activity, Log}

  @moduledoc """
  Enables to log activity in a structured way to a MySQL database. The logs are saved in a non blocking way, to minimize overhead in your application when logging.

  The actual insertion in the dabase is done by using Elixir's `Task` functionality.

  The `log` functions accepts a `ExActivity.Log` struct which is then saved to the database.

  Log like so:
      ExActivity.log(%ExActivity.Log{type: "error", action: "saveUser", result: "invalid_email"})
  """

  @doc false

  @spec log(Log.t) :: Activity.t
  def log(%Log{} = log) do
    Map.from_struct(log)
    |> process_log()
  end

  def log(%Log{} = log, conn) do
    log
    |> Map.from_struct()
    |> Map.merge(parse_conn(conn))
    |> process_log()
  end

  defp process_log(attrs) do
    attrs = cast(attrs)
    Task.start_link(fn -> Activity.log(attrs) end)
  end

  defp get_ip(conn) do
    to_string(:inet_parse.ntoa(conn.remote_ip))
  end

  defp parse_conn(conn) do
    %{
      user_agent: get_conn_header(conn, "user-agent"),
      ip: get_ip(conn)
    }
  end

  defp get_conn_header(conn, header) do
    headers = Enum.into(conn.req_headers, %{})
    case headers[header] do
      nil -> ""
      _ -> headers[header]
    end
  end

  defp cast(attrs) do
    attrs
    |> cast_integers()
  end

  defp cast_integers(attrs) do
    case Map.has_key?(attrs, :details) && is_integer(attrs.details) do
      true ->
        attrs
        |> Map.put(:details, Integer.to_string(attrs.details))

      _ ->
        attrs
    end
  end
end
