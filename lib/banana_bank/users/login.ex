defmodule BananaBank.Users.Login do
  alias BananaBank.Users

  def call(id, password) do
    with {:ok, user} <- Users.get(id),
         true <- check_password(password, user) do
      {:ok, user}
    end
  end

  def check_password(password, user) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> true
      _ -> {:error, :unauthorized}
    end
  end
end
