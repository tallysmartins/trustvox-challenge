defmodule TrustvoxWeb.CompaniesView do
  use TrustvoxWeb, :view

  def back_to_new(company) do
    "/complains/new?company_id=" <> Integer.to_string(company.id)
  end
end
