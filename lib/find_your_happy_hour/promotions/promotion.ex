defmodule FindYourHappyHour.Promotions.Promotion do
  use Ecto.Schema
  import Ecto.Changeset

  schema "promotions" do
    field :description, :string
    field :end_hour, :time
    field :picture, :string
    field :start_hour, :time
    field :title, :string
    field :week_day, :integer
    field :company_id, :id

    many_to_many :categories, FindYourHappyHour.Categories.Category,
      join_through: "promotions_categories"

    timestamps()
  end

  @doc false
  def changeset(promotion, attrs) do
    promotion
    |> cast(attrs, [:title, :description, :week_day, :start_hour, :end_hour, :picture])
    |> validate_required([:title, :description, :week_day, :start_hour, :end_hour, :picture])
  end
end
