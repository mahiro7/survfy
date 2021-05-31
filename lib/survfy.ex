defmodule Survfy do
  alias Survfy.Surveys.Create, as: SurveyCreate
  alias Survfy.Questions.Create, as: QuestionCreate

  defdelegate create_survey(params), to: SurveyCreate, as: :call
  defdelegate create_question(params), to: QuestionCreate, as: :call

end
