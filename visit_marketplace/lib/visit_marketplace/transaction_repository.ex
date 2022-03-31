defmodule VisitMarketplace.TransactionRepository do
  use GenServer
  alias VisitMarketplace.Transaction

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:create, member, pal, visit}, state) do
    {
      :noreply,
      Map.put(state, visit.id, Transaction.create(member, pal, visit))
    }
  end

  def create_transaction(pid, member, pal, visit) do
    GenServer.call({:create, member, pal, visit})
  end

end
