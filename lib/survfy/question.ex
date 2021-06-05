defmodule Survfy.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Survey, Choice, Answer, Accounts.User, Question}

  @foreign_key_type :id

  @required_fields [:name, :users_id]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "questions" do
    field :name, :string

    belongs_to :users, User

    has_many :answers, Answer
    has_many :choices, Choice

    timestamps()
  end

  @doc false
  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> cast_assoc(:choices)
    |> foreign_key_constraint(:users_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1)
  end

  def change_question(%__MODULE__{} = question) do
    Question.changeset(%{})
  end
end
