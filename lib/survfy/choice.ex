defmodule Survfy.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  schema "choices" do
    field :key, :integer
    field :name, :string
    #field :question_id, :id
    belongs_to :question, Survfy.Question
    has_many :answers, Survfy.Answer

    timestamps()
  end

  @fields ~w(key name question_id)

  @doc false
  def changeset(choice, attrs) do
    choice
    |> cast(attrs, [:key, :name])
    |> validate_required([:key, :name])
  end
end
