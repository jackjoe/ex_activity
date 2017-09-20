defmodule ExActivityTest do
  use ExUnit.Case
  doctest ExActivity

  alias ExActivity.{Log}

  # test "log/1 saves a log" do
  #   log = ExActivity.log(%Log{
  #     type: "some_log",
  #     action: "get_users",
  #     result: "some_result",
  #   })
  #   assert log.type == "some_log"
  # end
  #
  # test "log/1 accepts integer for detail but saves as string" do
  #   log = ExActivity.log(%Log{
  #     type: "some_log",
  #     action: "get_users",
  #     result: "some_result",
  #     details: 123
  #   })
  #   assert log.details == "123"
  #   assert log.details !== 123
  # end
end
