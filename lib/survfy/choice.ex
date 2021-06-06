defmodule Survfy.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Question, Answer, Choice}

  @foreign_key_type :id

  @required_fields [:name]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}

  schema "choices" do
    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true
    field :key, :string
    field :name, :string

    belongs_to :question, Question

    has_many :answers, Answer

    timestamps()
  end

  @doc false
  def changeset(choice, params) do
    choice
    |> Map.put(:temp_id, (choice.temp_id || params["temp_id"]))
    |> cast(params, [:name, :question_id, :temp_id])
    |> foreign_key_constraint(:name)
    |> foreign_key_constraint(:question_id)
    |> unique_constraint(:question_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min:  1)
    |> maybe_mark_for_deletion()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, [:name, :question_id, :temp_id])
    |> foreign_key_constraint(:name)
    |> foreign_key_constraint(:question_id)
    |> unique_constraint(:question_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min:  1)
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset
  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end

  def change_choice(%Choice{} = choice) do
    Choice.changeset(choice, %{})
  end
end
