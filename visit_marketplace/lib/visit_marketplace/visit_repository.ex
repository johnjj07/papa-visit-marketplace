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

  def handle_cast({:add_visit, member, minutes, tasks}, state) do
    {id, visits} = state
    visit = Visit.create(id, member, minutes, tasks)
    new_visits =
    {
      :noreply,
      {
        id + 1,
        Map.update(visits, visit.member, [visit], fn existing -> [visit | existing] end)
      }
    }
  end

  def list_all(pid) do
    GenServer.call(pid, {:current})
      |> Enum.map(fn {k, v} -> v end)
      |> List.flatten()
  end

  def create_visit(pid, member, minutes, tasks) do
    GenServer.cast(pid, {:add_visit, member, minutes, tasks})
  end
end
