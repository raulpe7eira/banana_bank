defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}),
    do: %{message: "Account created successfully", data: data(account)}

  defp data(%Account{} = account) do
    %{
      id: account.id,
      user_id: account.user_id,
      balance: account.balance
    }
  end
end
