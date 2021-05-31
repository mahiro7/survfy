defmodule Survfy do
  alias Survfy.Surveys.Create, as: SurveyCreate
  alias Survfy.Questions.Create, as: QuestionCreate
  alias Survfy.Choices.Create, as: ChoiceCreate
  alias Survfy.Answers.Create, as: AnswerCreate
  alias Survfy.Voters.Create, as: VoterCreate

  defdelegate create_survey(params), to: SurveyCreate, as: :call
  defdelegate create_question(params), to: QuestionCreate, as: :call
  defdelegate create_choice(params), to: ChoiceCreate, as: :call
  defdelegate create_answer(params), to: AnswerCreate, as: :call
  defdelegate create_voter(params), to: VoterCreate, as: :call

end
