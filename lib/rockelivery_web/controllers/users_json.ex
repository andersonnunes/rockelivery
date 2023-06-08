defmodule RockeliveryWeb.UsersJSON do
  alias Rockelivery.User

  def create(%{token: token, user: %User{} = user}) do
    %{
      message: "User created!",
      token: token,
      user: user
    }
  end

  def show(%{user: %User{} = user}), do: %{user: user}
end
