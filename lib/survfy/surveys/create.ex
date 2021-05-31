defmodule Survfy.Surveys.Create do
  alias Survfy.{Repo, Survey}

  def call(params) do
    params
    |> Survey.changeset()
    |> Repo.insert()
    |> handle_insert
  end

  defp handle_insert({:ok, %Survey{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
