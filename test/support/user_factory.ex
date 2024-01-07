defmodule BananaBank.UserFactory do
  alias BananaBank.Users.User

  defmacro __using__(_opts) do
    quote do
      def user_factory do
        %User{
          name: "Raul Pereira",
          password: "123",
          password_hash: Argon2.hash_pwd_salt("123"),
          email: sequence(:email, &"raul.pereira+#{&1}@mail.com"),
          cep: "12345678"
        }
      end
    end
  end
end
