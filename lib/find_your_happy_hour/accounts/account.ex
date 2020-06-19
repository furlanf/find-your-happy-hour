defmodule FindYourHappyHour.Accounts.Account do
  import Ecto.Query, warn: false

  alias FindYourHappyHour.Repo
  alias FindYourHappyHour.Accounts.User
  alias FindYourHappyHour.Accounts.Encryption
  alias FindYourHappyHour.Guardian

  alias Bcrypt

  def token_sign_in(email, password) do
    case email_password_auth(email, password) do
      {:ok, user} -> Guardian.encode_and_sign(user)
      _ -> {:error, :unauthorized}
    end
  end

  defp email_password_auth(email, password) when is_binary(email) and is_binary(password) do
    with {:ok, user} <- get_by_email(email),
         do: verify_password(user, password)
  end

  defp get_by_email(email) when is_binary(email) do
    case Repo.get_by(User, email: email) do
      nil ->
        {:error, "Login error."}

      user ->
        {:ok, user}
    end
  end

  defp verify_password(%User{} = user, password) when is_binary(password) do
    if Encryption.validate_password(user, password) do
      {:ok, user}
    else
      {:error, :invalid_password}
    end
  end
end
