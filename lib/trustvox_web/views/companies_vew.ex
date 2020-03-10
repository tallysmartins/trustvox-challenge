
defmodule TrustvoxWeb.CompaniesView do
  use TrustvoxWeb, :view

  def back_to_new(company) do
    "/complains/new?company_id=" <> Integer.to_string(company.id)
  end

  def valid_states() do
    ~w(AC AL AP AM BA CE DF ES GO MA MT MS MG PA
          PB PR PE PI RJ RN RS RO RR SC SP SE TO)
  end
end
