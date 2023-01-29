defmodule Api.Handlers.Time do
  import Plug.Conn
  alias Mongo.InsertOneResult

  @spec log(atom | %{:remote_ip => any, optional(any) => any}) :: any
  def log(conn) do
    ip = conn.remote_ip
          |> :inet_parse.ntoa()
          |> to_string()
    log = LogStruct.make(ip)

    {:ok, %InsertOneResult{:inserted_id => id}}
      = Mongo.insert_one(:api, "timestamps", log)

    result
      = Mongo.find_one(:api, "timestamps", %{_id: id})

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(201, Jason.encode!(result))
  end

  @spec list_entries(atom | %{:remote_ip => any, optional(any) => any}) :: any
  def list_entries(conn) do
    cursor
      = Mongo.find(:api, "timestamps", %{}, limit: 10, sort: %{:time => -1})
    entries = Enum.to_list(cursor)

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Jason.encode!(entries))
  end
end
