defmodule SurvfyWeb.QuestionsController do
  use SurvfyWeb, :controller

  alias Survfy.Question
  alias SurvfyWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Question{} = question} <- Survfy.create_question(params) do
      conn
      |> put_status(:created)
      |> render("create.json", question: question)
    end
  end
end
