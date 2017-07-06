defmodule ChanState.StatefulChannel do
  use ChanState.Web, :channel

  ## in the join function load previous
  ## state if available
  def join("topic", _payload, socket) do
      result = :ets.lookup(:holder, :state)
      case result do
      
        [] ->
          :ets.insert(:holder, {:state, []})
          {:ok, assign(socket, :ns, [])}
        
        [state: value] when length(value) > 0 ->
          {:ok, assign(socket, :ns, value)}
     
      end
  end

  ## adds a number to the ns list
  def handle_in("add", %{"n" => n}, socket) do
    ns = socket.assigns[:ns]
    new_ns = ns ++ [n]
    {:noreply, assign(socket, :ns, new_ns)}
  end

  ## returns the ns list
  def handle_in("get", _, socket) do
    ns = socket.assigns[:ns]
    {:reply, {:ok, %{"ns" => ns}}, socket}
  end

  ## causes a crash when called
  def handle_in("oopsy", _, socket) do
    a = 1 / 0
    {:noreply, socket}
  end

  ## remove key from :ets table when normal shutdown
  def terminate({:shutdown, _}, _socket) do
    :ets.delete(:holder, :state)
    :shutdown
  end

  ## backup state in :ets table when crash
  def terminate(_, socket) do
    :ets.insert(:holder, {:state, socket.assigns[:ns]})
    :shutdown
  end
end
