defmodule Survfy.Voter do
  use Ecto.Schema
  import Ecto.Changeset

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
  def changeset(voter, attrs) do
    voter
    |> cast(attrs, [:session])
    |> validate_required([:session])
  end
end
