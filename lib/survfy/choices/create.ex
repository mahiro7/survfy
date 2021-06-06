defmodule Survfy.Choices.Create do
  alias Survfy.{Repo, Choice}

  def call(params) do
    Choice.changeset(params)
    |> Repo.insert()
    |> handle_insert
  end

  defp handle_insert({:ok, %Choice{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
