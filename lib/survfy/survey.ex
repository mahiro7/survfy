defmodule Survfy.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  schema "surveys" do
    field :name, :string
    field :user_id, :id
    has_many :questions, Survfy.Question
    has_many :voters, Survfy.Voter

    timestamps()
  end

  @required_fields ~w(name user_id)

  @doc false
  def changeset(survey, attrs) do
    survey
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
