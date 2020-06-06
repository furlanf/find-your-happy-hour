defmodule FindYourHappyHour.Repo do
  use Ecto.Repo,
    otp_app: :find_your_happy_hour,
    adapter: Ecto.Adapters.Postgres
end
