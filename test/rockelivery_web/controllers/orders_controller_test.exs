defmodule RockeliveryWeb.OrdersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  alias RockeliveryWeb.Auth.Guardian

  import Rockelivery.Factory

  describe "create/2" do
    setup %{conn: conn} do
      user = insert(:user)
      insert(:item)
      {:ok, token, _claims} = Guardian.encode_and_sign(user)
      conn = put_req_header(conn, "authorization", "Bearer #{token}")

      {:ok, conn: conn, user: user}
    end

    test "when all params are valid, creates the item", %{conn: conn} do
      params = %{
        "address" => "Avenida Paulista",
        "comments" => "Por favor, suco natural.",
        "items" => [
          %{
            "id" => "9a6c1941-71e0-4e83-91b5-6ba61005bb1c",
            "quantity" => 2
          }
        ],
        "payment_method" => "money",
        "user_id" => "b6de1b73-21c8-4b7b-af6b-bec5803d7f56"
      }

      response =
        conn
        |> post("/api/orders", params)
        |> json_response(:created)

      assert %{
               "message" => "Order created!",
               "order" => %{
                 "address" => "Avenida Paulista",
                 "comments" => "Por favor, suco natural.",
                 "id" => _id,
                 "items" => [
                   %{
                     "category" => "drink",
                     "description" => "Suco de uva",
                     "id" => "9a6c1941-71e0-4e83-91b5-6ba61005bb1c",
                     "photo" => "/priv/suco_uva.png",
                     "price" => "9.5"
                   },
                   %{
                     "category" => "drink",
                     "description" => "Suco de uva",
                     "id" => "9a6c1941-71e0-4e83-91b5-6ba61005bb1c",
                     "photo" => "/priv/suco_uva.png",
                     "price" => "9.5"
                   }
                 ],
                 "payment_method" => "money",
                 "user_id" => "b6de1b73-21c8-4b7b-af6b-bec5803d7f56"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      response =
        conn
        |> post("/api/orders", %{items: []})
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "comments" => ["can't be blank"],
          "payment_method" => ["can't be blank"],
          "user_id" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end

    test "when item id is invalid, returns the error", %{conn: conn} do
      response =
        conn
        |> post("/api/orders", %{
          items: [%{"id" => "4b00a66b-2a39-43f5-a3f6-e578272bd95c", "quantity" => 2}]
        })
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid ids!"}

      assert response == expected_response
    end
  end
end
