defmodule Survfy.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Survey, Choice, Answer}

  @foreign_key_type :integer

  @required_fields [:name, :survey_id]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "questions" do
    field :name, :string

    belongs_to :survey, Survey

    has_many :answers, Answer
    has_many :choices, Choice

    timestamps()
  end

  @fields ~w(name survey_id)

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:survey_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1)
  end
end
