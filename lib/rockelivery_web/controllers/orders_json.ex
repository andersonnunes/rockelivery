defmodule RockeliveryWeb.OrdersJSON do
  alias Rockelivery.Order

  def create(%{order: %Order{} = order}) do
    %{
      message: "Order created!",
      order: order
    }
  end
end
