# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :example_api_server_with_vuejs,
  ecto_repos: [ExampleApiServerWithVuejs.Repo]

# Configures the endpoint
config :example_api_server_with_vuejs, ExampleApiServerWithVuejsWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "qipVVQz2T237VDXdYZzjoEeI5tN07Z4eDBtUCAkQCvE28arEMF3UuYu5ojm2g7KT",
  render_errors: [view: ExampleApiServerWithVuejsWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExampleApiServerWithVuejs.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
