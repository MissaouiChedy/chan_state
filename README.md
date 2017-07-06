# ChanState

A small example of [conserving channel instance assigned state between crashes](http://blog.techdominator.com/article/elixir-phoenix-conserving-channel-instance-assigned-state-between-crashes.html).

## You may want to check the following
- `web/channels/stateful_channel.ex` which contains the example channel
- `test/channels/stateful_channel_test.exs` which contains a test case demonstrating state conservation between crashes
- `lib/chan_state.ex` which contains the initialization of the relevant `:ets` table.

## To run the test case

  * Install dependencies with `mix deps.get`
  * Run the test with `mix test test/channels/stateful_channel_test.exs`


## Learn more about phoenix

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix
