defmodule ExActivity do
  alias ExActivity.{Activity, Log}

  @moduledoc """
  Enables to log activity in a structured way to a MySQL database. The logs are saved in a *non blocking way*, to minimize overhead in your application when logging.

  The actual insertion in the dabase is done by using Elixir's `Task` functionality.

  The `log` functions accepts a `ExActivity.Log` struct which is then saved to the database. Why the extra struct? Because the compiler is your friend.

  Log like so:

      ExActivity.log(%ExActivity.Log{
        type: "AuthController",
        action: "login",
        result: "ERROR",
        details: "invalid_email"
      })

  ## Properties
    * `type` - gives more context about the action you are logging; it could be the name of the controller where you log from, the context, ...
    * `action` - method name, sub-action in method, ...
    * `result` - outcome of the action such as ERROR, SUCCESS, WRONG_CODE, ...
    * `details` - more like meta date about current state
    * `data` - raw data, request parameters, db result, ...

  _For now everything should be string or integer (for some fields), we will try to expand this to accept more data/struct like structures, and encode them to JSON._

  ## It's a web world
  Next to the `ExActivity.log/1` method, there is also a `ExActivity.log/2` method that accepts a `Plug.Conn` conn as the second parameter. This way, the IP address and user agent will get appended to the log. For us, this is helpful information.

  """

  @doc """
  Accepts a `ExActivity.Log` struct and saves it to the database
  """
  @spec log(Log.t) :: Activity.t
  def log(%Log{} = log) do
    attrs = Map.from_struct(log)
    process_log(attrs)
  end

  @doc """
  Accepts a `ExActivity.Log` struct and a `Plug.Conn` conn and saves it to the database. The `conn` provides extra metadata like the IP address and user agent.
  """
  @spec log(Log.t, any) :: Activity.t
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
