defmodule ToReplaceWeb.Components.Confirmation do
  @moduledoc """
  Provide a validation pop-up before confirming an action
  """

  alias ToReplaceWeb.Helpers

  use Phoenix.Component

  def confirmation(assigns) do
    id = Ecto.UUID.generate() |> binary_part(0, 8)
    id_message = "#{id}_message"
    id_content = "#{id}_content"

    ~H"""
    <div class="relative">
    <div id={id_content} onclick={"window.APP.visibility.switch('#{id_message}')"}>
    <%= render_slot(@content, %{}) %>
    </div>
    <div class="absolute bg-white border shadow z-50 hidden bottom-0 p-4 rounded flex" id={id_message}>
    <div class="flex-grow">
    <%= render_slot(@message, %{}) %>
    <span class="absolute top-0 right-0 confirmation-icon-span" onclick={"window.APP.visibility.switch('#{id_message}')"}>
    <%= Helpers.Action.icon "close" %>
    </span>
    </div>

    </div>
    </div>
    """
  end
end
