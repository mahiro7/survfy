defmodule Survfy.Question do
  use Ecto.Schema
  import Ecto.Changeset

  schema "questions" do
    field :name, :string
    field :survey_id, :id
    has_many :choices, Survfy.Choice
    has_many :answers, Survey.Answer

    timestamps()
  end

  @fields ~w(name survey_id)

  @doc false
  def changeset(question, attrs) do
    question
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
