defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.User

  def user_params_factory do
    %{
      age: 34,
      address: "Rua Teste",
      cep: "09951000",
      cpf: "01234567890",
      email: "anderson@email.com",
      password: "123456",
      name: "Anderson"
    }
  end

  def user_factory do
    %User{
      id: "b6de1b73-21c8-4b7b-af6b-bec5803d7f56",
      age: 34,
      address: "Rua Teste",
      cep: "09951000",
      cpf: "01234567890",
      email: "anderson@email.com",
      password: "123456",
      name: "Anderson"
    }
  end
end
