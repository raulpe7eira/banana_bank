defmodule BananaBank.Repo.Migrations.AddUniqueConstraintToAccountsTable do
  use Ecto.Migration

  def change do
    create unique_index(:accounts, [:user_id])
  end
end
