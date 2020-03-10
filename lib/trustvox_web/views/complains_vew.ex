defmodule TrustvoxWeb.ComplainsView do
  use TrustvoxWeb, :view

  @doc """
    Generate a tuple from a list of subsidiaries to be used
    in a select field.

    Ex:
    subsidiaries = [
      %Subsidiary{id: 1, state: "SP", city: "São Paulo"},
      %Subsidiary{id: 2, state: "DF", city: "Brasilia"}
    ]

    subsidiaries_to_string(subsidiaries)
    iex()-> [{"SP - São Paulo, 1}, {"DF - Brasília. 2}]
  """
  def subsidiaries_to_string(subsidiaries) when is_list(subsidiaries) do
    subsidiaries
    |> Enum.map(&{&1.state <> " - " <> &1.city, &1.id})
    |> IO.inspect()
  end
end
