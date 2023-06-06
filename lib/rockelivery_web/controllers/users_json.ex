defmodule RockeliveryWeb.UsersJSON do
  alias Rockelivery.User

  def create(%{user: %User{} = user}) do
    %{
      message: "User created!",
      user: user
    }
  end

  def show(%{user: %User{} = user}), do: %{user: user}
end
