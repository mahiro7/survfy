defmodule SurvfyWeb.ChoicesView do
  use SurvfyWeb, :view

  def render("create.json", %{choice: choice}) do
    %{
      message: "Choice created!",
      choice: choice
    }
  end
end
