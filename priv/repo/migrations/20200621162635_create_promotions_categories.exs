defmodule FindYourHappyHour.Repo.Migrations.CreatePromotionsCategories do
  use Ecto.Migration

  def change do
    create table(:promotions_categories) do
      add :promotion_id, references(:promotions)
      add :category_id, references(:categories)
    end

    create unique_index(:promotions_categories, [:promotion_id, :category_id])
  end
end
