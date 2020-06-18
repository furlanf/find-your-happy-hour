defmodule FindYourHappyHour.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias FindYourHappyHour.Accounts.Encryption
  
  schema "users" do
    field :email, :string
    field :encrypted_password, :string
    field :name, :string

    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :password])
    |> validate_required([:name, :email, :password])
    |> validate_length(:password, min: 8)
    |> validate_format(:email, ~r/@/)
    |> validate_confirmation(:password)
    |> unique_constraint(:email)
    |> encrypt_password
  end

  defp encrypt_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      encrypted_password = Encryption.hash_password(password)
      put_change(changeset, :encrypted_password, encrypted_password)
    else
      changeset
    end
  end

end
