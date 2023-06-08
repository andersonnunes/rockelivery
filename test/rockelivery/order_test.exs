defmodule Rockelivery.OrderTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.Order

  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:order_params)
      items = [build(:item)]

      response = Order.changeset(params, items)

      assert %Changeset{
               changes: %{address: "Avenida Paulista"},
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:order_params)
      items = [build(:item)]

      update_params = %{payment_method: :credit_card}

      response =
        params
        |> Order.changeset(items)
        |> Order.changeset(update_params, items)

      assert %Changeset{
               changes: %{payment_method: :credit_card},
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:order_params, %{address: "Rua", comments: "Com"})

      response = Order.changeset(params, [])

      expected_response = %{
        address: ["should be at least 10 character(s)"],
        comments: ["should be at least 6 character(s)"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
