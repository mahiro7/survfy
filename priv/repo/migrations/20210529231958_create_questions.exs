defmodule Survfy.Repo.Migrations.CreateQuestions do
  use Ecto.Migration

  def change do
    create table(:questions) do
      add :name, :string
      add :survey_id, references(:surveys, on_delete: :nothing)

      timestamps()
    end

    create index(:questions, [:survey_id])
  end
end
