defmodule FindYourHappyHourWeb.CompanyView do
  use FindYourHappyHourWeb, :view
  alias FindYourHappyHourWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    %{data: render_many(companies, CompanyView, "company.json")}
  end

  def render("show.json", %{company: company}) do
    %{data: render_one(company, CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{id: company.id,
      name: company.name,
      description: company.description,
      address: company.address,
      lat_long: company.lat_long,
      picture: company.picture,
      cover_picture: company.cover_picture}
  end
end
