defmodule SurvfyWeb.VotersView do
  use SurvfyWeb, :view

  def render("create.json", %{voter: voter}) do
    %{
      message: "Voter created!",
      voter: voter
    }
  end
end
