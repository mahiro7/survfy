defmodule Survfy.Repo.Migrations.CreateVoters do
  use Ecto.Migration

  def change do
    create table(:voters) do
      add :session, :string
      add :user, references(:users, on_delete: :nothing)
      add :question_id, references(:questions, on_delete: :nothing)

      timestamps()
    end

    create index(:voters, [:user])
    create index(:voters, [:question_id])
  end
end
