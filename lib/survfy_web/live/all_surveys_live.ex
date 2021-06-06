defmodule SurvfyWeb.AllSurveysLive do
  use SurvfyWeb, :live_view

  alias Survfy.{Repo, Question, Questions.Get}
  alias SurvfyWeb.AllSurveysLive, as: Questions

  def mount(_params, _session, socket) do
    allQuestions =
      Repo.all(Question)
      |> Repo.preload(:choices)

    socket =
      socket
      |> assign(questions: Get.get_all())

    {:ok, socket}
  end

  def handle_event("voteOnQuestion", %{"id" => id}, socket) do
    {:noreply,
     socket
     |> redirect(to: "/survey/#{id}")}
  end
end
