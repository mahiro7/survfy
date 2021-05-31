defmodule Survfy.Questions.Create do
  alias Survfy.{Repo, Question}

  def call(params) do
    params
    |> Question.changeset()
    |> Repo.insert()
    |> handle_insert
  end

  defp handle_insert({:ok, %Question{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
