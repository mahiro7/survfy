defmodule SurvfyWeb.SurveyVoteLive do
  use SurvfyWeb, :live_view

  import Ecto.Query

  alias Survfy.{Repo, Accounts, Question, Choice}
  alias Survfy.Questions.Get, as: Questions
  alias Survfy.Choices.Get, as: Choices
  alias Survfy.Voters.Create, as: Voters
  alias Survy.Answers.Create, as: Answers

  def mount(%{"id" => id} = params, %{"_csrf_token" => token} = session, socket) do
     choices =
      from(Choice, where: [question_id: ^id])
      |> Repo.all

      changeset =

     assigns = [
        token: token,
        question: Questions.get_question!(id),
        choices: choices
      ]
      IO.inspect(token)

    {:ok, assign(socket, assigns)}
  end

  def create_voter(_, _, socket) do
    # First verify if %{session: token, question_id: question}
    # already exists
    assigns = socket.assigns
    token = assigns.token
    question = assigns.question.id
    Voters.call(%{session: token, question_id: question})
  end

  #def vote(_, _, _) do
  #  voter =
#
  #  Answers.call(%{voter_id: voter, choice_id: choice})
  #end
end
