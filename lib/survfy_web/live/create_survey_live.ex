defmodule SurvfyWeb.CreateSurveyLive do
  use SurvfyWeb, :live_view

  alias Survfy.{Repo, Question, Accounts, Questions.Get, Choice}
  alias Survfy.Questions.Create, as: Questions
  alias Survfy.Choices.Create, as: Choices
  alias SurvfyWeb.SurveysController

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    question =
      get_question(session)
      |> Map.put(:choices, [%Choice{temp_id: get_temp_id()}])

    changeset =
      Question.change_question(question)
      |> Ecto.Changeset.put_assoc(:choices, question.choices)

    assigns = [
      user: user,
      changeset: changeset,
      choicenumber: [3],
      question: question
    ]

    {:ok, assign(socket, assigns)}
  end

  def handle_event("validate", %{"question" => %{"name" => name} = question} = params, socket) do
    %{user: user} = socket.assigns

    res =
      question
      |> Map.put("users_id", user.id)

    changeset =
      socket.assigns.question
      |> Question.changeset(res)
      |> Map.put(:action, :insert)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("save", _, socket) do
    changeset = socket.assigns.changeset

    %{name: name, users_id: id, choices: choices} = changeset.changes
    # Enum.map(choices, fn x -> IO.inspect x.data end)

    {:ok, res} = Questions.call(%{name: name, users_id: id})
    %{id: questionid} = res

    Enum.map(choices, fn x ->
      # IO.inspect socket
      x.changes
      |> Map.put(:question_id, questionid)
      |> Map.put(:temp_id, x.data.temp_id)
      |> Choices.call()
    end)

    # IO.inspect changeset

    case changeset.valid? do
      true ->
        # Create.call(changeset.changes)
        {:noreply,
         socket
         |> put_flash(:info, "Questão inserida")
         |> redirect(to: "/mysurveys")}

      false ->
        {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
    end
  end

  def handle_event("add-choice", _, socket) do
    vars = Map.get(socket.assigns.changeset.changes, :choices, socket.assigns.question.choices)

    choices =
      vars
      |> Enum.concat([
        Choice.change_choice(%Choice{temp_id: get_temp_id()})
      ])

    IO.inspect(socket.assigns.changeset)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:choices, choices)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def handle_event("remove-variant", %{"remove" => remove_id}, socket) do
    choices =
      socket.assigns.changeset.changes.choices
      |> Enum.reject(fn %{data: choice} ->
        choice.temp_id == remove_id
      end)

    changeset =
      socket.assigns.changeset
      |> Ecto.Changeset.put_assoc(:choices, choices)

    {:noreply, assign(socket, changeset: changeset)}
  end

  def get_question(%{"id" => id} = _question_params), do: Get.get_question!(id)
  def get_question(_question_params), do: %Question{choices: []}

  defp get_temp_id, do: :crypto.strong_rand_bytes(5) |> Base.url_encode64() |> binary_part(0, 5)
end
