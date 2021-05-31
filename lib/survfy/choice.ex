defmodule Survfy.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Question, Answer}

  @foreign_key_type :id

  @required_fields [:key, :name, :question_id]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}

  schema "choices" do
    field :key, :integer
    field :name, :string

    belongs_to :question, Question

    has_many :answers, Answer

    timestamps()
  end

  @fields ~w(key name question_id)

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:name)
    |> foreign_key_constraint(:question_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min:  1)
  end
end
