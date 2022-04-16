defmodule ToReplaceWeb.LayoutView do
  use ToReplaceWeb, :view

  # Phoenix LiveDashboard is available only in development by default,
  # so we instruct Elixir to not warn if the dashboard route is missing.
  @compile {:no_warn_undefined, {Routes, :live_dashboard_path, 2}}

  def entry_menu(assigns) do
    ~H"""
    <a href={assigns[:url]} class={get_a_class(assigns)}>
    	<%= Helpers.Action.icon assigns[:icon] %>
    <span class="ml-2">
    	<%= assigns[:title] %>
    </span>
    </a>
    """
  end

  defp get_a_class(assigns) do
    color = if Keyword.has_key?(assigns, :color), do: assigns[:color], else: "blue"

    if Keyword.has_key?(assigns, :selected) && assigns[:selected] do
      "flex justify-center block py-1 md:py-3 pl-1 pr-1 align-middle text-blue-400 no-underline border-b-2 border-white border-#{color}-400 hover:border-#{color}-400"
    else
      "flex justify-center block py-1 md:py-3 pl-1 pr-2 align-middle text-gray-500 no-underline border-b-2 border-white hover:border-#{color}-400"
    end
  end
end
