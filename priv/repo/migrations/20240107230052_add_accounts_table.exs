defmodule BananaBank.Repo.Migrations.AddAccountsTable do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :balance, :decimal, null: false
      add :user_id, references(:users), null: false

      timestamps()
    end

    create constraint(:accounts, "balance_must_be_positive", check: "balance >= 0")
  end
end
