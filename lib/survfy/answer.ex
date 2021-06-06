defmodule Survfy.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Voter, Question, Choice}

  @foreign_key_type :id

  @required_fields [:voter_id, :choice_id]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}

  schema "answers" do
    #field :voter_id, :id
    #field :question_id, :id
    #field :choice_id, :id
    belongs_to :voter, Voter
    #belongs_to :question, Question
    belongs_to :choice, Choice

    timestamps()
  end

  @fields ~w(voter_id question_id choice_id)

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    #|> foreign_key_constraint(:question_id)
    |> foreign_key_constraint(:choice_id)
    |> foreign_key_constraint(:voter_id)
    |> validate_required(@required_fields)
  end
end
