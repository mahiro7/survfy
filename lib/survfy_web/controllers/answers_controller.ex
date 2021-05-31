defmodule SurvfyWeb.AnswersController do
  use SurvfyWeb, :controller

  alias Survfy.Answer
  alias SurvfyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Answer{} = answer} <- Survfy.create_answer(params) do
      conn
      |> put_status(:created)
      |> render("create.json", answer: answer)
    end
  end
end
