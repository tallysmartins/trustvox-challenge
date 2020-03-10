defmodule Trustvox.Complains.Complains do
  import Ecto.Query

  alias Trustvox.Complains.Complain
  alias Trustvox.Repo

  def create_complain(attrs) do
    %Complain{}
    |> Complain.changeset(attrs)
    |> Repo.insert()
  end

  def create_complain(attrs, %{id: id} = _subsidiary) do
    attrs
    |> Map.put(:subsidiary_id, id)
    |> create_complain()
  end

  def last_complains(limit \\ 100) when is_integer(limit) do
    Complain
    |> limit(^limit)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end
end
