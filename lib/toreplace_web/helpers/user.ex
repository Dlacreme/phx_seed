defmodule ToReplaceWeb.Helpers.User do
  use Phoenix.HTML
  alias ToReplace.Account.User

  def name_or_email(%User{email: email, profile: %{name: name}}) do
    content_tag(
      :span,
      [
        content_tag(
          :span,
          if name != "" && name != nil do
            name
          else
            email
          end
        )
      ],
      class: ""
    )
  end

  def name_or_email(_) do
    content_tag(:div, "")
  end

  def name(%User{profile: %{name: name}}) do
    content_tag(
      :span,
      [
        content_tag(
          :span,
          name
        )
      ],
      class: ""
    )
  end

  def name(_), do: content_tag(:div, "")

  def is_admin?(%User{type_id: "admin"}), do: true
  def is_admin?(_u), do: false
end
