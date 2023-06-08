defmodule RockeliveryWeb.ItemsJSONTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.Item
  alias RockeliveryWeb.ItemsJSON

  test "renders create.json" do
    item = build(:item)

    response = ItemsJSON.create(%{item: item})

    assert %{
             item: %Item{
               id: "9a6c1941-71e0-4e83-91b5-6ba61005bb1c",
               category: :drink,
               description: "Suco de uva",
               price: 9.5,
               photo: "/priv/suco_uva.png",
               orders: _orders,
               inserted_at: nil,
               updated_at: nil
             },
             message: "Item created!"
           } = response
  end
end
