defmodule VisitMarketplace.VisitRepository do
  use GenServer
  alias VisitMarketplace.Visit

  def start_link() do
    GenServer.start_link(__MODULE__, nil)
  end

  def init(_) do
    {:ok, {1, %{}}}
  end

  def handle_call({:current}, _from, state) do
    {_, visits} = state
    {:reply, visits, state}
  end

  def handle_call({:add_visit, member, minutes, tasks}, _from, state) do
    {id, visits} = state
    visit = Visit.create(id, member, minutes, tasks)
    new_visits = Map.put(visits, id, visit)
    {:reply, {:ok, visit}, {id + 1, new_visits}}
  end

  def list_all(pid) do
    GenServer.call(pid, {:current})
      |> Enum.map(fn {k, v} -> v end)
      |> List.flatten()
  end

  def create_visit(pid, member, minutes, tasks) do
    GenServer.call(pid, {:add_visit, member, minutes, tasks})
  end
end
