defmodule BananaBankWeb.Token do
  alias BananaBank.Users.User
  alias BananaBankWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "banana_bank_api"

  def sign(%User{} = user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token) do
    Token.verify(Endpoint, @sign_salt, token)
  end
end
