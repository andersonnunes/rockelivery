defmodule Rockelivery.UserTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.User

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = %{
        age: 34,
        address: "Rua Teste",
        cep: "09951000",
        cpf: "01234567890",
        email: "anderson@teste",
        password: "123456",
        name: "Anderson"
      }

      response = User.changeset(params)

      assert %Changeset{changes: %{name: "Anderson"}, valid?: true} = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = %{
        age: 34,
        address: "Rua Teste",
        cep: "09951000",
        cpf: "01234567890",
        email: "anderson@teste",
        password: "123456",
        name: "Anderson"
      }

      update_params = %{name: "Thomas Anderson", password: "123456"}

      response =
        params
        |> User.changeset()
        |> User.changeset(update_params)

      assert %Changeset{changes: %{name: "Thomas Anderson"}, valid?: true} = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = %{
        age: 15,
        address: "Rua Teste",
        cep: "09951000",
        cpf: "01234567890",
        email: "anderson@teste",
        password: "12345",
        name: "Anderson"
      }

      response = User.changeset(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
