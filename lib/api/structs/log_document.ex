defmodule LogDocument do
  @moduledoc """
  IP Address log document structure
  """

  @fields [:_id, :ip, :time]
  @enforce_keys @fields
  defstruct @fields

  defimpl Mongo.Encoder do
    @spec encode(%__MODULE__{}) :: %{_id: BSON.ObjectId.t(), ip: String.t(), time: DateTime.t()}
    def encode(%LogDocument{_id: id, ip: ip, time: time}) do
      %{
        _id: id,
        ip: ip,
        time: time
      }
    end
  end
end
