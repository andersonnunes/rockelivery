defmodule Rockelivery.Factory do
  use ExMachina.Ecto, repo: Rockelivery.Repo

  alias Rockelivery.{Item, Order, User}

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

  def item_params_factory do
    %{
      category: :drink,
      description: "Suco de uva",
      price: 9.50,
      photo: "/priv/suco_uva.png"
    }
  end

  def order_params_factory do
    %{
      user_id: "f02a1660-e2a1-4ca4-8ce8-e90a19a91e6f",
      items: [
        %{
          id: "a64aefa7-1989-4499-bf31-d14309e83479",
          quantity: 3
        }
      ],
      address: "Avenida Paulista",
      comments: "Sem canela na banana",
      payment_method: "money"
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

  def item_factory do
    %Item{
      id: "9a6c1941-71e0-4e83-91b5-6ba61005bb1c",
      category: :drink,
      description: "Suco de uva",
      price: 9.50,
      photo: "/priv/suco_uva.png"
    }
  end

  def order_factory do
    %Order{
      user_id: "f02a1660-e2a1-4ca4-8ce8-e90a19a91e6f",
      items: [
        %{
          id: "a64aefa7-1989-4499-bf31-d14309e83479",
          quantity: 3
        }
      ],
      address: "Avenida Paulista",
      comments: "Sem canela na banana",
      payment_method: "money"
    }
  end
end
