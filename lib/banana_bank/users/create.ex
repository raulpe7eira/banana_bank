defmodule BananaBank.Users.Create do
  alias BananaBank.Repo
  alias BananaBank.Users.User
  alias BananaBank.ViaCep.ClientImpl, as: ViaCepClientImpl

  def call(params) do
    with {:ok, _result} <- via_cep_client_impl().call(params) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp via_cep_client_impl() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClientImpl)
  end
end
