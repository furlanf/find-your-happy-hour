defmodule FindYourHappyHour.Companies.Company do
  use Ecto.Schema
  import Ecto.Changeset

  schema "companies" do
    field :address, :string
    field :cover_picture, :string
    field :description, :string
    field :lat_long, :string
    field :name, :string
    field :picture, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, [:name, :description, :address, :lat_long, :picture, :cover_picture])
    |> validate_required([:name, :description, :address, :lat_long, :picture, :cover_picture])
  end
end
