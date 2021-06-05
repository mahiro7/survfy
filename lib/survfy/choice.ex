defmodule Survfy.Choice do
  use Ecto.Schema
  import Ecto.Changeset

  alias Survfy.{Question, Answer}

  @foreign_key_type :id

  @required_fields [:key, :name, :question_id, :delete]

  @derive {Jason.Encoder, only:  @required_fields ++ [:id]}

  schema "choices" do
    field :temp_id, :string, virtual: true
    field :delete, :boolean, virtual: true
    field :key, :integer
    field :name, :string

    belongs_to :question, Question

    has_many :answers, Answer

    timestamps()
  end

  @doc false
  def changeset(choice, params) do
    choice
    |> Map.put(:temp_id, (choice.temp_id || params["temp_id"]))
    |> cast(params, @required_fields)
    |> foreign_key_constraint(:name)
    |> foreign_key_constraint(:question_id)
    |> validate_required(@required_fields)
    |> validate_length(:name, min:  1)
    |> maybe_mark_for_deletion()
  end

  defp maybe_mark_for_deletion(%{data: %{id: nil}} = changeset), do: changeset
  defp maybe_mark_for_deletion(changeset) do
    if get_change(changeset, :delete) do
      %{changeset | action: :delete}
    else
      changeset
    end
  end
end
