defmodule RockeliveryWeb.ItemsJSON do
  alias Rockelivery.Item

  def create(%{item: %Item{} = item}) do
    %{
      message: "Item created!",
      item: item
    }
  end
end
