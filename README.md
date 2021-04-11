# Oriza [![Coverage Status](https://coveralls.io/repos/github/rmparr/oriza/badge.svg?branch=main)](https://coveralls.io/github/rmparr/oriza?branch=main)

A way to add contexts to function calls. Given:

```elixir
defmodule MyModule do
  use Oriza.Context

  @context admin: [:read, :write]
  def do_something(arg), do: arg
end
```

Creates the following additional function definition:

```elixir
def do_something(context, arg) do
  with :ok <- check_context(context) do
    do_something(arg)
  else
    _ -> {:error, "access denied"}
end
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `oriza` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:oriza, "~> 0.0.1"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/oriza](https://hexdocs.pm/oriza).
