defmodule FindYourHappyHour.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create table(:companies) do
      add :name, :string
      add :description, :string
      add :address, :string
      add :lat_long, :string
      add :picture, :string
      add :cover_picture, :string
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:companies, [:user_id])
  end
end
