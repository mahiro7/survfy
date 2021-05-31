defmodule SurvfyWeb.QuestionsView do
  use SurvfyWeb, :view

  def render("create.json", %{question: question}) do
    %{
      message: "Question created!",
      question: question
    }
  end
end
