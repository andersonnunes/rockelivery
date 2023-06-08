defmodule RockeliveryWeb.ItemsControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  alias RockeliveryWeb.Auth.Guardian

  import Rockelivery.Factory

  describe "create/2" do
    setup %{conn: conn} do
      user = insert(:user)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when all params are valid, creates the item", %{conn: conn} do
      params = %{
        "category" => :drink,
        "description" => "Suco de uva",
        "photo" => "/priv/suco_uvo.png",
        "price" => "9.50"
      }

      response =
        conn
        |> post("/api/items", params)
        |> json_response(:created)

      assert %{
               "message" => "Item created!",
               "item" => %{
                 "category" => "drink",
                 "description" => "Suco de uva",
                 "photo" => "/priv/suco_uvo.png",
                 "price" => "9.50"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      response =
        conn
        |> post("/api/items", %{})
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "category" => ["can't be blank"],
          "description" => ["can't be blank"],
          "photo" => ["can't be blank"],
          "price" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end

    test "when category is invalid, returns the error", %{conn: conn} do
      response =
        conn
        |> post("/api/items", %{
          "category" => :almoco,
          "description" => "Suco de uva",
          "photo" => "/priv/suco_uvo.png",
          "price" => "9.50"
        })
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "category" => ["is invalid"]
        }
      }

      assert response == expected_response
    end
  end
end
