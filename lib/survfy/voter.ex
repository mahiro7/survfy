defmodule Survfy.Voter do
  use Ecto.Schema
  import Ecto.Changeset

  @foreign_key_type :id

  @required_fields [:session, :user, :survey_id ]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}


  schema "voters" do
    field :session, :string
    field :user, :id
    #field :survey_id, :id
    belongs_to :survey, Survfy.Survey
    has_many :answers, Survfy.Answer

    timestamps()
  end

  @fields ~w(session survey_id)

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:survey_id)
    |> validate_required(@required_fields)
  end
end
