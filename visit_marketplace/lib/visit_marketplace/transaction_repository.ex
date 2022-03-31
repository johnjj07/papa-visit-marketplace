defmodule VisitMarketplace.TransactionRepository do
  use GenServer
  alias VisitMarketplace.Transaction

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:create, member, pal, visit}, state) do
    transaction = Transaction.create(member, pal, visit)
    {
      :reply,
      transaction,
      Map.put(state, visit.id, transaction)
    }
  end

  def create_transaction(pid, member, pal, visit) do
    GenServer.call({:create, member, pal, visit})
  end

end
