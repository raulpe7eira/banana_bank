defmodule BananaBank.Accounts.Transaction do
  alias BananaBank.Accounts.Account
  alias BananaBank.Repo
  alias Ecto.Multi

  def call(%{
        "from_account_id" => from_account_id,
        "to_account_id" => to_account_id,
        "amount" => amount
      }) do
    with {:ok, amount} <- Decimal.cast(amount),
         %Account{} = from_account <- Repo.get(Account, from_account_id),
         %Account{} = to_account <- Repo.get(Account, to_account_id) do
      Multi.new()
      |> withdraw(from_account, amount)
      |> deposit(to_account, amount)
      |> Repo.transaction()
      |> handle_transaction()
    else
      nil -> {:error, :invalid_account}
      :error -> {:error, :invalid_amount}
    end
  end

  def call(_), do: {:error, :invalid_transaction}

  defp deposit(multi, account, amount) do
    new_balance = Decimal.add(account.balance, amount)
    new_changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :deposit, new_changeset)
  end

  defp withdraw(multi, account, amount) do
    new_balance = Decimal.sub(account.balance, amount)
    new_changeset = Account.changeset(account, %{balance: new_balance})
    Multi.update(multi, :withdraw, new_changeset)
  end

  defp handle_transaction({:ok, _} = result), do: result
  defp handle_transaction({:error, _, reason, _}), do: {:error, reason}
end
