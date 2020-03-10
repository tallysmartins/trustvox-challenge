# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trustvox.Repo.insert!(%Trustvox.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Trustvox.Complains.{Complains, Complain}
alias Trustvox.Companies.{Companies, Company, Company.Subsidiary}

companies = [
  %{name: "Leroy", website: "www.leroy.com"},
  %{name: "Ifood", website: "www.ifood.com"},
  %{name: "Casas Bahia", website: "casas.bahia.br"},
  %{name: "Lojão Torra Torra", website: "lojao.com.voce"},
  %{name: "Cia dos pés", website: "ciadospes.uol.br"},
  %{name: "Sabin", website: "www.sabin.com.br"},
  %{name: "Ragazzo Torra Torra", website: "ragazzu.br"},
  %{name: "Apple Bee", website: "restaurante.apple.bee"},
  %{name: "Canto da Ema", website: "www.forrodaema.com.br"}
]

locations = [
  %{city: "Brasilia", state: "DF"},
  %{city: "Patos de Minas", state: "MG"},
  %{city: "São Bernardo", state: "SP"},
  %{city: "São Paulo", state: "SP"}
]

complains = [
  %{title: "Broken piece", description: "Shipping problems has broken my piece"},
  %{title: "I will never return", description: "I don't know why people like this place."},
  %{title: "Poor design", description: "Does not fit the purpose as it was mentioned in the video. Didn not liked"}
]

:rand.seed(:exsplus, {101, 102, 103})

create_complain = fn number_of_comments, subsidiary ->
   1..number_of_comments
   |> Enum.each(fn n ->
        Enum.at(complains, Integer.mod(n, length(complains)))
        |> Complains.create_complain(subsidiary)
   end)
end

# Insert the company in all given subsidiary locations
# After that create a random number of comments (up to 10) for each subsidiary location
insert = fn company ->
  {:ok, company} =
    Map.put(company, :subsidiaries, locations)
    |> Companies.create_company()

  Enum.each(company.subsidiaries, fn sub ->
    create_complain.(Enum.random(1..10), sub)
  end)
end

# For each company execute insert
companies
|> Enum.each(insert)
