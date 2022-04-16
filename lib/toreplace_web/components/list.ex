defmodule ToReplaceWeb.Components.List do
  @moduledoc """
  Build a cool looking list.

  A `render` function with the list of items must be provided to `render`
  """
  use Phoenix.Component

  def list(assigns) do
    ~H"""
    <div class="rounded">
    <%= for item <- @items do %>
      <div class="bg-white shadow p-3 pl-5 pr-5 hover:mb-2 hover:mt-2 hover:shadow-l pointer transition">
    <%= render_slot(@inner_block, item) %>
    </div>
    <% end %>
    </div>
    """
  end
end
