defmodule Survfy.Voter do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :id

  @required_fields [:session, :question_id ]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}


  schema "voters" do
    field :session, :string
    field :user, :id
    #field :survey_id, :id
    belongs_to :questions, Survfy.Question
    has_many :answers, Survfy.Answer

    timestamps()
  end

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:question_id)
    |> validate_required(@required_fields)
  end
end
