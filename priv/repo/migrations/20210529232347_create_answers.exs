defmodule Survfy.Repo.Migrations.CreateAnswers do
  use Ecto.Migration

  def change do
    create table(:answers) do
      add :voter_id, references(:voters, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)
      add :choice_id, references(:choices, on_delete: :nothing)

      timestamps()
    end

    create index(:answers, [:voter_id])
    create index(:answers, [:question_id])
    create index(:answers, [:choice_id])
  end
end
