defmodule Survfy.Repo.Migrations.CreateSurveys do
  use Ecto.Migration

  def change do
    create table(:surveys) do
      add :name, :string
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end
  end
end
