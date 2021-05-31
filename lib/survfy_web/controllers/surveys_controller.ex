defmodule SurvfyWeb.SurveysController do
  use SurvfyWeb, :controller

  alias Survfy.Survey
  alias SurvfyWeb.FallbackController

  alias SurvfyWeb.CreateSurveyLive

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %Survey{} = survey} <- Survfy.create_survey(params) do
      conn
      |> put_status(:created)
      |> render("create.json", survey: survey)
    end
  end
end
