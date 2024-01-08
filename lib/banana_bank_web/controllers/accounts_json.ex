defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{message: "Account created successfully", data: data(account)}
  end

  def transaction(%{transaction: transaction}) do
    %{
      message: "Amount transferred successfully",
      from_data: data(transaction.withdraw),
      to_data: data(transaction.deposit)
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      user_id: account.user_id,
      balance: account.balance
    }
  end
end
