defmodule Api.Router do
  alias Mongo.InsertOneResult
  use Plug.Router

  plug(Plug.Logger)

  plug(:match)

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:dispatch)

  get "/" do
    conn = put_resp_content_type(conn, "application/json")

    send_resp(
      conn,
      200,
      Jason.encode!(%{
        :app => "api-example",
        :version => "0.0.1"
      })
    )
  end

  get "/time/log" do
    Api.Handlers.Time.log(conn)
  end

  get "/time/entries" do
    Api.Handlers.Time.list_entries(conn)
  end

  match _ do
    send_resp(conn, 404, "Not Found")
  end
end
