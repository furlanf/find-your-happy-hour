# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :find_your_happy_hour,
  ecto_repos: [FindYourHappyHour.Repo]

# Configures the endpoint
config :find_your_happy_hour, FindYourHappyHourWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pak3nOwRfEM3zWFi4FmbcpFd7v/+UM7ZH2HfRy8kAc0zf3nlWrrhhBWbRs6CY8pq",
  render_errors: [view: FindYourHappyHourWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FindYourHappyHour.PubSub,
  live_view: [signing_salt: "dACQ7+yv"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :find_your_happy_hour, FindYourHappyHour.Guardian,
       issuer: "find_your_happy_hour",
       secret_key: "czEIvZmIVZo1Yuck7NHvsIYUbc5oCmL+X1bFHTMUQ0/N+dCRYUt+IsCD4TZZHIFH"

config :bcrypt_elixir, log_rounds: 4

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
