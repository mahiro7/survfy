defmodule SurvfyWeb.VotersController do
  use SurvfyWeb, :controller

  alias Survfy.Voter
  alias SurvfyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Voter{} = voter} <- Survfy.create_voter(params) do
      conn
      |> put_status(:created)
      |> render("create.json", voter: voter)
    end
  end
end
