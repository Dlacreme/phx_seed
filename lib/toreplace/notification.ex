defmodule ToReplace.Notification do
  @moduledoc """
  Provide helpers to send email & SMS
  """

  defmodule Recipient do
    defstruct name: nil, entity: nil, email: nil, phone_number: nil
  end

  @spec send(list(%Recipient{}) | %Recipient{}, binary(), binary(), any()) ::
          :ok | {:error, any()}
  def send(%Recipient{} = rec, subject, template, data) do
    __MODULE__.Mail.send(rec, subject, template, data)
    send_sms(rec, template, data)
  end

  def send(recipients, subject, template, data) do
    recipients
    |> Enum.each(&send(&1, subject, template, data))

    :ok
  end

  defmodule Mail do
    use Phoenix.Swoosh, view: ToReplaceWeb.MailerView

    def send(%Recipient{email: nil}, _s, _t, _d), do: {:error, :email_not_provided}

    def send(%Recipient{email: email}, subject, template, data) do
      IO.puts("[#{email}] => #{inspect(data)}")

      new()
      |> from("notification@to_replace.com")
      |> to(email)
      |> subject(subject)
      |> render_body(template, data)
    end
  end

  def send_sms(%Recipient{phone_number: nil}, _t, _d), do: {:error, :phone_number_not_provided}

  def send_sms(%Recipient{phone_number: phone_number}, _template, data) do
    IO.puts("[#{phone_number}] => #{inspect(data)}")
    :ok
  end
end
