defmodule SurvfyWeb.FallbackController do
  use SurvfyWeb, :controller

  def call(conn, {:error, %{result: result, status: status}}) do
    conn
    |> put_status(status)
    |> put_view(SurvfyWeb.ErrorView)
    |> render("error.json", result: result)
  end
end
