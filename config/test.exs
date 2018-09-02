use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :example_api_server_with_vuejs, ExampleApiServerWithVuejsWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :example_api_server_with_vuejs, ExampleApiServerWithVuejs.Repo,
  adapter: Ecto.Adapters.MySQL,
  username: "root",
  password: "",
  database: "example_api_server_with_vuejs_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
