defmodule Survfy.Choices.Get do
  import Ecto.Query

  alias Survfy.{Repo, Question, Choice}

  def get_choice!(id) do
    Repo.get(Choice, id)
  end

  def get_by_question(id) do
    Repo.get_by(Choice, question_id: id)
  end

  #def get_all do
  #  Repo.all(Choices)
  #  |> Repo.preload(:choices)
  #end
end
