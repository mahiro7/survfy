defmodule SurvfyWeb.SurveyVoteLive do
  use SurvfyWeb, :live_view

  alias Survfy.{Repo, Accounts, Question, Questions.Get}

  def mount(%{"id" => id} = params, session, socket) do
     user = Accounts.get_user_by_session_token(session["user_token"])

     assigns = [
        user: user.id,
        question: Get.get_question(id)
      ]
      IO.inspect(user)

    {:ok, assign(socket, assigns)}
  end
end
