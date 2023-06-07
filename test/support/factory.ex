defmodule Rockelivery.Factory do
  use ExMachina

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
end
