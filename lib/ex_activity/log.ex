defmodule ExActivity.Log do
  @moduledoc """
  Log struct, which can be passed to the `ExActivity.log/1` or `ExActivity.log/2`. For more info about logging, see `ExActivity`
  """

  @type t :: %ExActivity.Log{
    type: String.t,
    action: String.t,
    result: String.t,
    details: String.t | integer,
    data: String.t | integer
  }
  @enforce_keys [:type, :action, :result]
  defstruct action: nil, result: nil, type: nil, details: nil, data: nil
end
