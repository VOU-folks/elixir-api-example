defmodule LogStruct do
  @fields [:ip, :time]
  defstruct @fields

  @spec make(String.t()) :: %LogStruct{ip: any, time: DateTime.t()}
  def make(ip) do
    %LogStruct{
      ip: ip,
      time: DateTime.utc_now()
    }
  end
end
