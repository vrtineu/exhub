defmodule Exhub.Error do
  @moduledoc """
  The Error module is responsible for defining the error struct.
  """

  defstruct [:message, :status_code]

  def new(message, status_code) do
    %__MODULE__{message: message, status_code: status_code}
  end
end
