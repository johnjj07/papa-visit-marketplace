defmodule VisitMarketplace do
  @moduledoc """
  Documentation for `VisitMarketplace`.
  """

  def start() do
    {:ok, pid} = Supervisor.start_child(VisitMarketplace.Supervisor, [])
    pid
  end

  def add_user(pid, first_name, last_name, email) do
    VisitMarketplace.UserRepository.add(pid, VisitMarketplace.User.create(email, first_name, last_name))
    # Validate email
    # lookup user by email to see if its unique
    # Create user
  end

  def state(pid) do
    IO.inspect(VisitMarketplace.UserRepository.current(pid))
  end

  def create_visit(pid, member, minutes, tasks) do
    VisitMarketplace.VisitRepository.create_visit(pid, member, minutes, tasks)
  end

  def accept_visit(pid, member, pal, visit) do
    #
  end
end
