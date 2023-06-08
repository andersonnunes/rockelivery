defmodule RockeliveryWeb.OrdersJSONTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Order
  alias RockeliveryWeb.OrdersJSON

  test "renders create.json" do
    order = build(:order)

    response = OrdersJSON.create(%{order: order})

    assert %{
             message: "Order created!",
             order: %Order{
               address: "Avenida Paulista",
               comments: "Sem canela na banana",
               id: nil,
               inserted_at: nil,
               items: [%{id: "a64aefa7-1989-4499-bf31-d14309e83479", quantity: 3}],
               payment_method: "money",
               updated_at: nil,
               user: _user,
               user_id: "f02a1660-e2a1-4ca4-8ce8-e90a19a91e6f"
             }
           } = response
  end
end
