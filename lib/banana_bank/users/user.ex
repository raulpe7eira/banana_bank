defmodule BananaBank.Users.User do
  use Ecto.Schema

  import Ecto.Changeset

  @fields ~w[name password email cep]a
  @required_fields @fields

  schema "users" do
    field :name, :string
    field :password, :string, redact: true, virtual: true
    field :password_hash, :string
    field :email, :string
    field :cep, :string

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @fields)
    |> validate_required(@required_fields)
    |> validate_length(:name, min: 3)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:cep, is: 8)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, %{password_hash: Argon2.hash_pwd_salt(password)})
  end

  defp put_pass_hash(changeset), do: changeset
end
