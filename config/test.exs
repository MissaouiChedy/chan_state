use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :chan_state, ChanState.Endpoint,
  http: [port: 4001],
  server: true

# Print only warnings and errors during test
config :logger, level: :warn
