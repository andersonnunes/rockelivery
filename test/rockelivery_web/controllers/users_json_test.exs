defmodule RockeliveryWeb.UsersJSONTest do
  use RockeliveryWeb.ConnCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.User
  alias RockeliveryWeb.UsersJSON

  test "renders create.json" do
    user = build(:user)

    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"

    response = UsersJSON.create(%{token: token, user: user})

    assert %{
             message: "User created!",
             user: %User{
               id: "b6de1b73-21c8-4b7b-af6b-bec5803d7f56",
               age: 34,
               address: "Rua Teste",
               cep: "09951000",
               cpf: "01234567890",
               email: "anderson@email.com",
               password: "123456",
               password_hash: nil,
               name: "Anderson",
               inserted_at: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders show.json" do
    user = build(:user)

    response = UsersJSON.show(%{user: user})

    assert %{
             user: %User{
               id: "b6de1b73-21c8-4b7b-af6b-bec5803d7f56",
               age: 34,
               address: "Rua Teste",
               cep: "09951000",
               cpf: "01234567890",
               email: "anderson@email.com",
               password: "123456",
               password_hash: nil,
               name: "Anderson",
               inserted_at: nil,
               updated_at: nil
             }
           } = response
  end

  test "renders sign_in.json" do
    token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"

    response = UsersJSON.sign_in(%{token: token})

    assert %{token: "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9"} == response
  end
end
