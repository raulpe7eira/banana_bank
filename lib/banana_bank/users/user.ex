defmodule BananaBank.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias BananaBank.Accounts.Account

  @fields ~w[name password email cep]a
  @create_required_fields @fields
  @update_required_fields @fields -- ~w[password]a

  schema "users" do
    field :name, :string
    field :password, :string, redact: true, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    has_one :account, Account

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params)

  def changeset(%__MODULE__{id: nil} = user, params) do
    user
    |> cast(params, @fields)
    |> do_validations(@create_required_fields)
    |> put_pass_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @fields)
    |> do_validations(@update_required_fields)
    |> put_pass_hash()
  end

  defp do_validations(changeset, required_fields) do
    changeset
    |> validate_required(required_fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})
  end

  defp put_pass_hash(changeset), do: changeset
end
