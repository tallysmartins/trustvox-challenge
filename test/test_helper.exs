ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Trustvox.Repo, :manual)

defmodule TrustvoxWeb.TestHelpers do
  @moduledoc false

  import ExUnit.Assertions

  defmacro assert_difference(queryable, value, do: expression) do
    quote do
      count_before = Trustvox.Repo.aggregate(unquote(queryable), :count, :id)
      unquote(expression)
      count_after = Trustvox.Repo.aggregate(unquote(queryable), :count, :id)

      difference = count_after - count_before

      assert(
        unquote(value) == difference,
        "expected #{unquote(queryable)} to differ by #{unquote(value)},
             but the difference was #{difference}"
      )
    end
  end
end
