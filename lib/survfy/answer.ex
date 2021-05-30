defmodule Survfy.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "answers" do
    #field :voter_id, :id
    #field :question_id, :id
    #field :choice_id, :id
    belongs_to :voter, Survfy.Voter
    belongs_to :question, Survfy.Question
    belongs_to :choice, Survfy.Choice

    timestamps()
  end

  @fields ~w(voter_id question_id choice_id)

  @doc false
  def changeset(answer, attrs) do
    answer
    |> cast(attrs, [])
    |> validate_required([])
  end
end
