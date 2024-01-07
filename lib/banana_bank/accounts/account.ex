defmodule BananaBank.Accounts.Acount do
  use Ecto.Schema

  import Ecto.Changeset

  alias BananaBank.Users.User

  @fields ~w[balance user_id]a
  @required_fields @fields

  schema "accounts" do
    field :balance, :decimal
    belongs_to :user, User

    timestamps()
  end

  def changeset(account \\ %__MODULE__{}, params) do
    account
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> check_constraint(:balance, name: :balance_must_be_positive)
  end
end
