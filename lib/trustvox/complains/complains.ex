defmodule Trustvox.Complains.Complains do
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

  def list_complains() do
    Repo.all(Complain)
  end
end
