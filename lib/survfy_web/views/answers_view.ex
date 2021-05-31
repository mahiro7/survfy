defmodule SurvfyWeb.AnswersView do
  use SurvfyWeb, :view

  def render("create.json", %{answer: answer}) do
    %{
      message: "Answer created!",
      answer: answer
    }
  end
end
