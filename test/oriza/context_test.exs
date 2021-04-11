defmodule Oriza.ContextTest do
  use ExUnit.Case
  alias Oriza.Context

  describe "new/1" do
    test "with valid keys" do
      user_keys = [user: :read]
      function_keys = [admin: [:read, :write]]

      assert %Context{keys: ^user_keys} = Context.new(user_keys)
      assert %Context{keys: ^function_keys} = Context.new(function_keys)
    end

    test "with invalid keys" do
      error_tuple = {:error, "invalid keys"}

      list_with_no_tuples = [1, 2, 3]
      mixed_list = [{:admin, [:read, :write]}, 1]

      assert Context.new(nil) == error_tuple
      assert Context.new(list_with_no_tuples) == error_tuple
      assert Context.new(mixed_list) == error_tuple
    end
  end

  describe "a module using Oriza" do
    defmodule S do
      use Oriza

      context(:test_function, [:arg_1, :arg_2], admin: [:read, :write])
      def test_function(arg_1, arg_2), do: arg_1 + arg_2
    end

    test "calls the un-contexted function" do
      assert S.test_function(1, 1) == 2
    end

    test "calls the contexted function with an allowed user context" do
      admin_read = Context.new(admin: [:read])
      admin_write = Context.new(admin: [:write])

      assert S.test_function(admin_read, 1, 1) == 2
      assert S.test_function(admin_write, 1, 1) == 2
    end

    test "calls the contexted function with a disallowed user context" do
      user_context = Context.new(user: [:read])

      assert {:error, "no access"} = S.test_function(user_context, 1, 1)
    end

    test "raised an error when the contexted function is called without a context" do
      assert_raise FunctionClauseError, fn -> S.test_function([admin: [:read]], 1, 1) end
      assert_raise FunctionClauseError, fn -> S.test_function(nil, 1, 1) end
    end
  end
end
