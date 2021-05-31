defmodule SurvfyWeb.SurveysView do
  use SurvfyWeb, :view

  def render("create.json", %{survey: survey}) do
    %{
      message: "Survey created!",
      survey: survey
    }
  end
end
