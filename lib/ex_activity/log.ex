defmodule ExActivity.Log do
  @moduledoc """
  Log struct.

  For now everything should be string or integer (for some fields), we will try to expand this to accept more data/struct like structures, and encode them to JSON.
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
