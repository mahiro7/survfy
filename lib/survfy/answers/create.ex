defmodule Survfy.Answers.Create do
  alias Survfy.{Repo, Answer}

  def call(params) do
    params
    |> Answer.changeset()
    |> Repo.insert()
    |> handle_insert
  end

  defp handle_insert({:ok, %Answer{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
