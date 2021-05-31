defmodule SurvfyWeb.ChoicesController do
  use SurvfyWeb, :controller

  alias Survfy.Choice
  alias SurvfyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Choice{} = choice} <- Survfy.create_choice(params) do
      conn
      |> put_status(:created)
      |> render("create.json", choice: choice)
    end
  end
end
