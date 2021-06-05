defmodule Survfy.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :name, :string
      add :users_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:users_id])
  end
end
