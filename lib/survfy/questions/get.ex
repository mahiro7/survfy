defmodule Survfy.Questions.Get do
  import Ecto.Query

  alias Survfy.{Repo, Question, Choice}

  def get_question!(id) do
    Repo.get(Question, id)
    |> Repo.preload(choices: from(c in Choice, order_by: c.id))
  end

  def get_by_user(id) do
    Repo.get_by(Question, users_id: id)
    |> Repo.preload(:choices)
  end

  def get_all do
    Repo.all(Question)
    |> Repo.preload(:choices)
  end
end
