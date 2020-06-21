defmodule FindYourHappyHour.Repo.Migrations.CreatePromotionCategories do
  use Ecto.Migration

  def change do
    create table(:promotion_categories) do
      add :promotion_id, references(:promotions)
      add :category_id, references(:categories)
    end

    create unique_index(:promotion_categories, [:promotion_id, :category_id])
  end
end
