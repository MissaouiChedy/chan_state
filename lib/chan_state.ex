defmodule ChanState do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      supervisor(ChanState.Endpoint, []),
    ]
    ## channel state backup
    :ets.new(:holder, [:set, :public, :named_table])
    
    opts = [strategy: :one_for_one, name: ChanState.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    ChanState.Endpoint.config_change(changed, removed)
    :ok
  end
end
