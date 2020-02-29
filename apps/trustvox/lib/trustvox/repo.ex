defmodule Trustvox.Repo do
  @moduledoc """
    In memory database for our records
  """
  alias Trustvox.Complains.Complain

  def all(Complain) do
    [%Complain{
        id: "1",
        title: "Broken product",
        description: "some description for broken product",
        locale: "Patos de Minas",
        company: "wallmart"},
      %Complain{
        id: "2",
        title: "Wrong product",
        description: "some description for wrong product",
        locale: "Patos de Minas",
        company: "wallmart"},
      %Complain{
        id: "3",
        title: "Very good product",
        description: "some compliment for very good product",
        locale: "Sao Paulo",
        company: "ludus"}
     ]
  end

  def all(_module), do: []

  def get(module, id) do
    Enum.find all(module), fn map -> map.id == id end
  end

  def get_by(module, params) do
    Enum.find all(module), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end
  end

  def insert(module, record) do
    [record | all(module)]
  end
end
