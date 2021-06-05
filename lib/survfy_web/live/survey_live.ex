defmodule SurvfyWeb.SurveyLive do
  use SurvfyWeb, :live_view

  def mount(params, session, socket) do
    IO.inspect(params)
    IO.inspect(session)
    IO.inspect(socket)

    {:ok, socket}
  end
end
