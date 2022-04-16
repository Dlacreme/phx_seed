defmodule ToReplace.Validators.PhoneNumber do
  @moduledoc """
  This module provide helpers to process phone number
  """

  def intl_phone_number_regex(), do: ~r/^\+([0-9]+)$/
end
