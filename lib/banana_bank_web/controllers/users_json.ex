defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}), do: %{message: "User created successfully", data: data(user)}

  def delete(%{user: user}), do: %{message: "User deleted successfully", data: data(user)}

  def show(%{user: user}), do: %{message: "User shown successfully", data: data(user)}

  def update(%{user: user}), do: %{message: "User updated successfully", data: data(user)}

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
