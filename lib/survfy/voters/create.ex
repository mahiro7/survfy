defmodule Survfy.Voters.Create do
  alias Survfy.{Repo, Voter}

  def call(params) do
    params
    |> Voter.changeset()
    |> Repo.insert()
    |> handle_insert
  end

  defp handle_insert({:ok, %Voter{}} = result), do: result
  defp handle_insert({:error, result}), do: {:error, %{result: result, status: :bad_request}}
end
