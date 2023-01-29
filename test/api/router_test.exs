defmodule Api.RouterTest do
  use ExUnit.Case, async: true

  use Plug.Test

  @opts Api.Router.init([])

  test "return 404" do
    request = conn(:get, "/unexistent-route")
    call = Api.Router.call(request, @opts)

    assert call.state == :sent
    assert call.status == 404
  end

  test "returns 200 and app info" do
    request = conn(:get, "/")
    call = Api.Router.call(request, @opts)

    assert call.state == :sent
    assert call.status == 200

    response = Jason.decode!(call.resp_body, %{keys: :atoms})
    assert response.app != nil
    assert response.app === "api-example"
  end
end
