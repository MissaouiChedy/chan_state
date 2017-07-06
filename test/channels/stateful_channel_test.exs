defmodule ChanState.StatefulChannelTest do
  use ChanState.ChannelCase

  alias ChanState.StatefulChannel

  setup do
    {:ok, _, socket} =
      socket()
      |> subscribe_and_join(StatefulChannel, "topic")

    {:ok, socket: socket}
  end

  test "should conserve channel state", %{socket: socket} do
    Process.unlink(socket.channel_pid)

    ## Add some values to the ns list
    push socket, "add", %{"n" => 2149}
    push socket, "add", %{"n" => 1234}
    
    ref = push socket, "get", %{}
    ## assert that the values are in
    assert_reply ref, :ok, %{"ns" => [2149, 1234]}
    
    ## cause the channel instance to crash
    push socket, "oopsy", %{}
    
    ## start a new channel instance
    {:ok, _, socket} =
       socket()
       |> subscribe_and_join(StatefulChannel, "topic")
     
    ref = push socket, "get", %{}
    ## assert that the state has been conserved
    assert_reply ref, :ok, %{"ns" => [2149, 1234]}, 1000
  end
  
end
