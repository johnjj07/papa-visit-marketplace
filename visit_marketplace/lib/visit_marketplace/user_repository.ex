defmodule VisitMarketplace.UserRepository do
  use GenServer

  alias VisitMarketplace.User

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, %{}}
  end

  def handle_call({:current}, _from, state) do
    {:reply, state, state}
  end

  def handle_cast({:add_user, %User{} = user}, state) do
    {:noreply, Map.put(state, user.email, user)}
  end

  def current(pid) do
    GenServer.call(pid, {:current})
  end

  def add(pid, user) do
    GenServer.cast(pid, {:add_user, user})
  end

end
