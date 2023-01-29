defimpl Jason.Encoder, for: BSON.ObjectId do
  @spec encode(BSON.ObjectId.t(), Jason.Encode.opts()) :: [
          binary | maybe_improper_list(any, binary | []) | byte,
          ...
        ]
  def encode(data, opts) do
    Jason.Encode.string(BSON.ObjectId.encode!(data), opts)
  end
end
