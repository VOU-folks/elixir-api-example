defmodule Api.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {
        Plug.Cowboy,
        scheme: :http,
        plug: Api.Router,
        options: [
          port: 10_080,
          ip: {127, 0, 0, 1}
          # ip: {0,0,0,0},
        ]
      },
      {
        Mongo,
        [
          name: :api,
          pool_size: 10,
          url: "mongodb://127.0.0.1/api"

          # url: "mongodb://username:password@127.0.0.1/api?params=here",
          # or
          # hostname: "127.0.0.1",
          # port: 27017,
          # database: "api",
          # username: "api",
          # password: "api",

          # ssl: true,
          # ssl options must be provided
          # if ssl: true
          # ssl_opts: [
          #   ciphers: ['AES256-GCM-SHA384'],
          #   cacertfile: "...",
          #   certfile: "...")
          # ],
        ]
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Api.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
