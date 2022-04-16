defmodule ToReplaceWeb.Helpers.Action do
  use Phoenix.HTML

  def label(content, color, props \\ []) do
    content_tag(
      :span,
      content,
      merge_props(props,
        class: "rounded-2xl p-2 pl-4 pr-4 inline-block text-white bg-#{color}-500"
      )
    )
  end

  def icon(name, props \\ []),
    do:
      content_tag(
        :i,
        name,
        merge_props(props, class: "material-icons", style: "max-width: 24px;")
      )

  def button(label, type, props \\ []) do
    content_tag(
      :button,
      label,
      merge_props(props, class: get_button_class(type))
    )
  end

  def icon_button(label, type, icon, props \\ []) do
    content_tag(
      :button,
      [
        icon(icon),
        content_tag(:span, label, class: "ml-2")
      ],
      merge_props(props, class: get_button_class(type))
    )
  end

  def icon_action(title, type, icon, props \\ []) do
    content_tag(
      :button,
      [
        icon(icon)
      ],
      merge_props(props, class: get_button_class(type), title: title)
    )
  end

  defp get_button_class(type) do
    "button shadow hover:shadow-xl flex items-center pointer #{Atom.to_string(type)}"
  end

  defp merge_props(props1, props2) do
    Keyword.merge(props1, props2, fn _k, p1, p2 -> "#{p1} #{p2}" end)
  end
end
