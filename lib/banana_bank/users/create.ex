defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(params) do
    with {:ok, _result} <- ViaCepClient.call(params) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
