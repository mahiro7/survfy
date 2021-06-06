defmodule SurvfyWeb.FirstPageLive do
  use SurvfyWeb, :live_view

  def render(assigns) do
    ~L"""
      <div class="text-center	">
        <h1 class="self-center pt-10">Bem vindo ao Survfy!</h1>
      </div>
    """
  end

end
