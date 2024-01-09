defmodule BananaBank.Users do
  alias BananaBank.Users.Create
  alias BananaBank.Users.Delete
  alias BananaBank.Users.Get
  alias BananaBank.Users.Update
  alias BananaBank.Users.Login

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(id), to: Get, as: :call
  defdelegate login(id, password), to: Login, as: :call
  defdelegate update(params), to: Update, as: :call
end
