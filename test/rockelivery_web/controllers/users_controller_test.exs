defmodule RockeliveryWeb.UsersControllerTest do
  use RockeliveryWeb.ConnCase, async: true

  import Mox
  import Rockelivery.Factory

  alias Rockelivery.ViaCep.ClientMock

  describe "create/2" do
    test "when all params are valid, creates the user", %{conn: conn} do
      params = %{
        "age" => 34,
        "address" => "Rua Teste",
        "cep" => "01001000",
        "cpf" => "01234567890",
        "email" => "anderson@email.com",
        "password" => "123456",
        "name" => "Anderson"
      }

      expect(ClientMock, :get_cep_info, fn _cep -> {:ok, build(:cep_info)} end)

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:created)

      assert %{
               "message" => "User created!",
               "user" => %{
                 "address" => "Rua Teste",
                 "age" => 34,
                 "cpf" => "01234567890",
                 "email" => "anderson@email.com",
                 "id" => _id,
                 "name" => "Anderson"
               }
             } = response
    end

    test "when there is some error, returns the error", %{conn: conn} do
      params = %{
        "password" => "123456",
        "name" => "Anderson"
      }

      response =
        conn
        |> post("/api/users", params)
        |> json_response(:bad_request)

      expected_response = %{
        "message" => %{
          "address" => ["can't be blank"],
          "age" => ["can't be blank"],
          "cep" => ["can't be blank"],
          "cpf" => ["can't be blank"],
          "email" => ["can't be blank"]
        }
      }

      assert response == expected_response
    end
  end

  describe "get/2" do
    test "when there is a user with the given id, returns the user", %{conn: conn} do
      id = "b6de1b73-21c8-4b7b-af6b-bec5803d7f56"
      insert(:user)

      response =
        conn
        |> get("/api/users/#{id}")
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua Teste",
                 "age" => 34,
                 "cpf" => "01234567890",
                 "email" => "anderson@email.com",
                 "id" => "b6de1b73-21c8-4b7b-af6b-bec5803d7f56",
                 "name" => "Anderson"
               }
             } == response
    end

    test "when there is a user with the invalid id, returns the error", %{conn: conn} do
      id = "invalid_id"

      response =
        conn
        |> get("/api/users/#{id}")
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid id format"}

      assert response == expected_response
    end

    test "when user is not exists, returns the error", %{conn: conn} do
      id = "e0f37599-2a7c-46c1-ae4e-fff0121bc819"

      response =
        conn
        |> get("/api/users/#{id}")
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "delete/2" do
    test "when there is a user with the given id, deletes the user", %{conn: conn} do
      id = "b6de1b73-21c8-4b7b-af6b-bec5803d7f56"
      insert(:user)

      response =
        conn
        |> delete("/api/users/#{id}")
        |> response(:no_content)

      assert response == ""
    end

    test "when user is not exists, returns the error", %{conn: conn} do
      id = "e0f37599-2a7c-46c1-ae4e-fff0121bc819"

      response =
        conn
        |> delete("/api/users/#{id}")
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end

  describe "update/2" do
    test "when all params are valid, updates the user", %{conn: conn} do
      id = "b6de1b73-21c8-4b7b-af6b-bec5803d7f56"
      insert(:user)

      params = %{
        "password" => "123456",
        "name" => "Thomas Anderson"
      }

      response =
        conn
        |> put("/api/users/#{id}", params)
        |> json_response(:ok)

      assert %{
               "user" => %{
                 "address" => "Rua Teste",
                 "age" => 34,
                 "cpf" => "01234567890",
                 "email" => "anderson@email.com",
                 "id" => id,
                 "name" => "Thomas Anderson"
               }
             } == response
    end

    test "when user is not exists, returns the error", %{conn: conn} do
      id = "e0f37599-2a7c-46c1-ae4e-fff0121bc819"

      response =
        conn
        |> put("/api/users/#{id}", %{})
        |> json_response(:not_found)

      expected_response = %{"message" => "User not found"}

      assert response == expected_response
    end
  end
end
