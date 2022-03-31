defmodule VisitMarketplace.Visit do
  alias VisitMarketplace.Visit

  @enforce_keys [:id, :member, :date, :minutes, :tasks, :state]
  defstruct [:id, :member, :date, :minutes, :tasks, state: :inactive]

  def create(id, member, date, minutes, tasks) do
    %Visit{id: id, member: member, date: date, minutes: minutes, tasks: tasks, state: :inactive}
  end

  def create(id, member, minutes, tasks) do
    create(id, member, DateTime.utc_now(), minutes, tasks)
  end
end
