defmodule BananaBank.Accounts.Create do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias BananaBank.Users

  def call(%{"user_id" => user_id} = params) do
    with :ok <- check_user(user_id) do
      params
      |> Account.changeset()
      |> Repo.insert()
    end
  end

  def call(_), do: {:error, :invalid_user}

  defp check_user(id) do
    case Users.get(id) do
      {:ok, _} -> :ok
      {:error, _} -> {:error, :invalid_user}
    end
  end
end
