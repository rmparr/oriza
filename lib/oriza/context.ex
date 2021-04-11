defmodule Oriza.Context do
  @moduledoc false
  defstruct [:keys]

  @type t :: %__MODULE__{
          :keys => [{atom(), atom() | [atom()]}]
        }

  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)

      @spec flatten_context(unquote(__MODULE__).t() | list(tuple())) :: list(tuple())
      defp flatten_context(%unquote(__MODULE__){keys: keys}), do: flatten_context(keys)

      defp flatten_context(keys) when is_list(keys) do
        Enum.flat_map(keys, fn {k, v} ->
          Enum.map(v, fn v -> {k, v} end)
        end)
      end

      defp check_context(user_context, function_context) do
        user_context = flatten_context(user_context)
        function_context = flatten_context(function_context)

        Enum.any?(user_context, &(&1 in function_context))
      end
    end
  end

  @spec context(atom(), list(atom()), list(tuple())) :: Macro.t()
  defmacro context(name, args, context) when is_atom(name) and is_list(args) do
    quote bind_quoted: [name: name, args: args, context: context] do
      args = Enum.map(args, &Macro.var(&1, __MODULE__))

      @doc """
      Wraps #{name}/#{length(args)} with a call using the provided context.

      Calling this with a user context in the first position will either call the underlying
      function or return an error tuple.
      """
      def unquote(name)(%Oriza.Context{} = user_context, unquote_splicing(args)) do
        if check_context(user_context, unquote(context)) do
          unquote(name)(unquote_splicing(args))
        else
          {:error, "no access"}
        end
      end
    end
  end

  @spec new(list(tuple)) :: t()
  def new(keys) when is_list(keys) do
    if Enum.all?(keys, &is_tuple/1) do
      %__MODULE__{keys: keys}
    else
      {:error, "invalid keys"}
    end
  end

  def new(_any), do: {:error, "invalid keys"}
end
