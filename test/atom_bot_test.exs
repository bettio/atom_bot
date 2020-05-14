defmodule AtomBotTest do
  use ExUnit.Case
  doctest AtomBot

  test "greets the world" do
    assert AtomBot.hello() == :world
  end
end
