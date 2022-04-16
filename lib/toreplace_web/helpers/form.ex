defmodule ToReplaceWeb.Helpers.Form do
  use Phoenix.HTML

  def money_input(form, name, props \\ []) do
    prefill = get_prefill(form, name)
    name = Phoenix.HTML.Form.input_name(form, name)
    amount_name = "#{name}[amount]"
    currency_name = "#{name}[currency]"

    content_tag(
      :div,
      [
        content_tag(
          :input,
          "",
          type: "number",
          name: amount_name,
          id: amount_name,
          class: "mr-2 flex-grow w-10",
          style: "width: 160px;",
          value: prefill.amount
        ),
        content_tag(
          :select,
          [
            content_tag(:option, "USD",
              value: "USD",
              selected: if(prefill.currency == :USD, do: "true", else: "false")
            ),
            content_tag(:option, "AED",
              value: "AED",
              selected: if(prefill.currency == :AED, do: "true", else: "false")
            )
          ],
          type: "text",
          name: currency_name,
          id: currency_name,
          value: prefill.currency
        )
      ],
      merge_props(props, class: "flex")
    )
  end

  defp merge_props(props1, props2) do
    Keyword.merge(props1, props2, fn _k, p1, p2 -> "#{p1} #{p2}" end)
  end

  defp get_prefill(%{data: data}, field_name) do
    case data
         |> Map.fetch(field_name) do
      :error ->
        Money.new(0, :USD)

      {:ok, v} ->
        if v != nil do
          v
        else
          Money.new(0, :USD)
        end
    end
  end

  defp get_prefill(_form, _name), do: Money.new(0, :USD)
end
