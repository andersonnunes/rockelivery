defmodule RockeliveryWeb.WelcomeControllerTest do
  use RockeliveryWeb.ConnCase

  test "returns correct message", %{conn: conn} do
    response =
      conn
      |> get("/api/")
      |> response(:ok)

    assert "Welcome 😊" == response
  end
end
