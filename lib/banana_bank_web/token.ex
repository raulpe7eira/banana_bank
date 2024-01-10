defmodule BananaBankWeb.Token do
  alias BananaBank.Users.User
  alias BananaBankWeb.Endpoint
  alias Phoenix.Token

  def sign(%User{} = user) do
    Token.sign(Endpoint, sign_salt_token(), %{user_id: user.id})
  end

  def verify(token) do
    Token.verify(Endpoint, sign_salt_token(), token)
  end

  def sign_salt_token do
    :banana_bank
    |> Application.get_env(__MODULE__)
    |> Keyword.fetch!(:sign_salt_token)
  end
end
