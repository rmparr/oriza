# Oriza [![Coverage Status](https://coveralls.io/repos/github/rmparr/oriza/badge.svg?branch=main)](https://coveralls.io/github/rmparr/oriza?branch=main)

A way to add contexts to function calls. Given:

```elixir
defmodule MyModule do
  use Oriza.Context

  context(:do_something, [:arg], [admin: [:read, :write]])
  def do_something(arg), do: arg
end
```

Creates the following additional function definition:

```elixir
def do_something(user_context, arg) do
  if check_context(user_context, %Oriza.Context{keys: [admin: [:read, :write]]}) do
    do_something(arg)
  else
    {:error, "access denied"}
end
```

## Installation

Oriza can be added as a project dependency:

```elixir
def deps do
  [
    {:oriza, "~> 0.0.3-alpha"}
  ]
end
```

After adding the dependency, modules can `use Oriza`, which will give access to the `context` macro.

## Contributing

### Git Hooks

GitHub Actions is going to run all of this anyway, so why not check before?

To remove any existing hooks and symlink the repo git hooks, run `mix run scripts/symlink_git_hooks.exs` from the command line.
