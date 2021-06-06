defmodule SurvfyWeb.SurveyVoteLive do
  use SurvfyWeb, :live_view

  import Ecto.Query

  alias Survfy.{Repo, Accounts, Question, Choice, Voter}
  alias Survfy.Questions.Get, as: Questions
  alias Survfy.Choices.Get, as: Choices
  alias Survfy.Voters.Create, as: Voters
  alias Survfy.Answers.Create, as: Answers

  def mount(%{"id" => id} = params, %{"_csrf_token" => token} = session, socket) do
    choices =
      from(Choice, where: [question_id: ^id])
      |> Repo.all()
      |> Repo.preload(:answers)

    %{"voted" => voted} = handle_params(params)
    votedbool = convert_voted(voted)

    totalvotes = get_total_votes(choices)

    assigns = [
      token: token,
      question: Questions.get_question!(id),
      choices: choices,
      voted: votedbool,
      totalvotes: totalvotes
    ]

    IO.inspect(votedbool)

    {:ok, assign(socket, assigns)}
  end

  def handle_params(%{"id" => id, "voted" => voted} = params), do: params
  def handle_params(%{"id" => id}), do: %{"id" => id, "voted" => "false"}

  def convert_voted("true"), do: true
  def convert_voted("false"), do: false


  def handle_event("submit", %{"choices" => choice} = params, socket) do
    assigns = socket.assigns
    token = assigns.token
    question = assigns.question.id
    choice = choice

    # First verify if %{session: token, question_id: question}
    # already exists
    case get_voter(token, question) do
      :ok ->
        handle_vote(token, question, choice)
        reload = reload_choices(question)

        {:noreply,
         socket
         |> assign(choices: reload)
         |> assign(totalvotes: get_total_votes(reload))
         |> assign(voted: true)
         |> put_flash(:info, "Votado!")}

      :err ->
        {:noreply,
         socket
         |> assign(totalvotes: get_total_votes(socket.assigns.choices))
         |> assign(voted: true)
         |> put_flash(:error, "Você já votou nessa enquete!")}
    end
  end

  def reload_choices(id) do
    from(Choice, where: [question_id: ^id])
    |> Repo.all()
    |> Repo.preload(:answers)
  end

  def get_total_votes(choices) do
    Enum.map(choices, fn x ->
      length(x.answers)
    end)
    # This is 100%
    |> Enum.sum()
  end

  def handle_vote(token, question, choice) do
    {:ok, res} = Voters.call(%{session: token, question_id: question})
    %{id: voterid} = res
    Answers.call(%{voter_id: voterid, choice_id: choice})
  end

  def get_voter(token, question) do
    Survfy.Repo.get_by(Voter, session: token, question_id: question)
    |> handle_getvoter
  end

  def handle_getvoter(nil), do: IO.inspect(:ok)
  def handle_getvoter(%Voter{}), do: IO.inspect(:err)
end
