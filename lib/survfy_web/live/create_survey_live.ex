defmodule SurvfyWeb.CreateSurveyLive do
  use SurvfyWeb, :live_view

  alias Survfy.{Repo, Question, Accounts, Questions}

  def mount(_params, session, socket) do
    user = Accounts.get_user_by_session_token(session["user_token"])

    changeset =
      Question.changeset(%{})

    socket =
      socket
      |> assign(user: user)
      |> assign(changeset: changeset)
    {:ok, socket}
  end


  def handle_event("validate", %{"question" => %{"title" => name}}, socket) do
    IO.inspect(name)
    %{user: user} = socket.assigns
    changeset = Question.changeset(%{name: name, users_id: user.id}) |> Map.put(:action, :insert)
    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"question" => %{"title" => name}}, socket) do
    changeset = socket.assigns.changeset
    case changeset.valid? do
      true ->
        Questions.Create.call(changeset.changes)
        {:noreply, socket
          |> put_flash(:info, "Question inserted => #{inspect(changeset.changes)}")
          |> redirect(to: "/mysurveys")
      }
      false ->
        {:noreply, assign(socket, :changeset, %{changeset | action: :insert})}
    end
  end

  def handle_event("add-choice", _, socket) do
    vars = Map.get(socket.assigns.changeset.changes, :choices, socket.assigns.question.choices)
    |> IO.inspect
    {:noreply, socket}
  end
end
