defmodule Survfy.Survey do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Question, Voter, Accounts.User}

  @required_fields [:name, :users_id]

  @derive {Jason.Encoder, only: @required_fields ++ [:id]}

  schema "surveys" do
    field :name, :string
    field :users_id, :id

    has_one :questions, Question
    has_many :voters, Voter

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:users_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 1)
  end
end

# {:ok, res} = Survfy.Repo.get(Survfy.Survey, 1) |> Survfy.Repo.preload(:questions)|> Map.fetch(:questions)
