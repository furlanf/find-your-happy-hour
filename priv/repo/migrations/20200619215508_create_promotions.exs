defmodule FindYourHappyHour.Repo.Migrations.CreatePromotions do
  use Ecto.Migration

  def change do
    create table(:promotions) do
      add :title, :string
      add :description, :text
      add :week_day, :integer
      add :start_hour, :time
      add :end_hour, :time
      add :picture, :string
      add :company_id, references(:companies, on_delete: :nothing)

      timestamps()
    end

    create index(:promotions, [:company_id])
  end
end
