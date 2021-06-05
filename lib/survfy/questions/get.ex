defmodule Survfy.Questions.Get do
  alias Survfy.{Repo, Question, Choice}

  def get_question(id) do
    Repo.get(Question, id)
    |> Repo.preload(:choices)
  end
end
