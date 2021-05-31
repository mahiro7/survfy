defmodule SurvfyWeb.UserRegistrationView do
  use SurvfyWeb, :view

  def render("create.json", %{user: user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
