defmodule SurvfyWeb.MySurveysLive do
  use SurvfyWeb, :live_view

  def render(assigns) do
    ~L"""
      <div>
        <h1>Texto</h1>
        <button>-</button>
        <button>+</button>
      </div>
    """
  end

end
