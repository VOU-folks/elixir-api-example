defmodule LogStruct do
  @moduledoc """
  IP Address log entry structure
  """

  @fields [:ip, :time]
  defstruct @fields

  @spec make(String.t()) :: %__MODULE__{ip: any, time: DateTime.t()}
  def make(ip) do
    %LogStruct{
      ip: ip,
      time: DateTime.utc_now()
    }
  end
end
