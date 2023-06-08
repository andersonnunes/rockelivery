defmodule Rockelivery.Items.CreateTest do
  use Rockelivery.DataCase, async: true

  import Rockelivery.Factory

  alias Rockelivery.{Error, Item}
  alias Rockelivery.Items.Create

  describe "call/1" do
    test "when all params are valid, returns the item" do
      params = build(:item_params)

      response = Create.call(params)

      assert {:ok, %Item{id: _id, description: "Suco de uva", price: _price}} =
               response
    end

    test "where there are invalid params, returns an error" do
      params = build(:item_params, %{description: "Suc", price: 0})
      response = Create.call(params)

      assert {:error, %Error{status: :bad_request, result: changeset}} = response

      expected_response = %{
        description: ["should be at least 6 character(s)"],
        price: ["must be greater than 0"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
