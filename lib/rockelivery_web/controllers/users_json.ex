defmodule RockeliveryWeb.UsersJSON do
  alias Rockelivery.User

  def create(%{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end
end
