defmodule Oriza do
  @moduledoc """
  Simple implementation to wrap a function in an allowed context.
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      import Oriza
      use Oriza.Context
    end
  end
end
