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

  def handle_call({:update_minutes, member_id, pal_id, visit_minutes}, _from, state) do
    member = Map.get(state, member_id)
    pal = Map.get(state, pal_id)
    swap_minutes(state, {member, pal, visit_minutes})
  end

  defp swap_minutes(state, {member, pal, visit_minutes}) when member.minutes >= visit_minutes do
    Map.update!(state, member.email, User.update_minutes(member, member.minutes - visit_minutes) )
    Map.update!(state, pal.email, User.update_minutes(pal, pal.minutes + floor(visit_minutes * 0.85)) )
    {:ok}
  end

  defp swap_minutes(state, {member, _, visit_minutes}) do
    {:error, "Member #{member.email} does not have #{visit_minutes} available to use"}
  end

  def handle_cast({:add_user, %User{} = user}, state) do
    {:noreply, Map.put(state, user.email, user)}
  end

  def current(pid) do
    GenServer.call(pid, {:current})
  end

  def user(pid, email) do
    current(pid)
    |> Map.get(email)
  end

  def add(pid, user) do
    GenServer.cast(pid, {:add_user, user})
  end

  def update_minutes(pid, member_id, pal_id, visit_minutes) do
    GenServer.call(pid, {:update_minutes, member_id, pal_id, visit_minutes})
  end
end
