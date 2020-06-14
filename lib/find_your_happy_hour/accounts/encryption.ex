defmodule FindYourHappyHour.Accounts.Encryption do
    alias Bcrypt
    alias FindYourHappyHour.Accounts.User

    def hash_password(password), do: Bcrypt.hash_pwd_salt(password)

    def validate_password(%User{} = user, password), do: Bcrypt.check_pass(user, password)
end