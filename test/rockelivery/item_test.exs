defmodule Rockelivery.ItemTest do
  use Rockelivery.DataCase, async: true

  alias Ecto.Changeset
  alias Rockelivery.Item

  import Rockelivery.Factory

  describe "changeset/2" do
    test "when all params are valid, returns a valid changeset" do
      params = build(:item_params)

      response = Item.changeset(params)

      assert %Changeset{
               changes: %{description: "Suco de uva"},
               valid?: true
             } = response
    end

    test "when updating a changeset, returns a valid changeset with the given changes" do
      params = build(:item_params)

      update_params = %{description: "Suco de laranja"}

      response =
        params
        |> Item.changeset()
        |> Item.changeset(update_params)

      assert %Changeset{
               changes: %{description: "Suco de laranja"},
               valid?: true
             } = response
    end

    test "when there are some error, returns an invalid changeset" do
      params = build(:item_params, %{description: "Suc", price: 0})

      response = Item.changeset(params)

      expected_response = %{
        description: ["should be at least 6 character(s)"],
        price: ["must be greater than 0"]
      }

      assert errors_on(response) == expected_response
    end
  end
end
