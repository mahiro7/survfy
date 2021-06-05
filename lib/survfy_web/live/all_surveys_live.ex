defmodule SurvfyWeb.AllSurveysLive do
  use SurvfyWeb, :live_view

  alias Survfy.{Repo, Question}
  alias SurvfyWeb.AllSurveysLive, as: Questions

  def mount(_params, _session, socket) do
    allQuestions =
      Repo.all(Question)
      |> Repo.preload(:choices)

    socket =
      socket
      |> assign(questions: allQuestions)
    {:ok, socket}
  end

  def handle_event("voteOnQuestion", %{"value" => value}, socket) do
    {:noreply, socket
      |> redirect(to: "survey")}
  end
end
