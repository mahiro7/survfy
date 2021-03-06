defmodule SurvfyWeb.MySurveysLive do
  use SurvfyWeb, :live_view

  import Ecto.Query

  alias Survfy.{Questions.Get, Accounts, Question, Repo}

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    questions =
      from(Question, where: [users_id: ^user.id])
      |> Repo.all()

    assigns = [
      user: user.id,
      questions: questions
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("seeResult", %{"id" => id} = params, socket) do
    IO.inspect(params)

    {:noreply,
     socket
     |> redirect(to: "/survey/#{id}/true")}
  end
end
