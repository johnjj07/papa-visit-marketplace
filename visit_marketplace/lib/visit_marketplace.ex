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

  def create_visit(pid, member_id, minutes, tasks) do
    available_minutes = VisitMarketplace.UserRepository.user(member_id).minutes
    create_visit(pid, {available_minutes, minutes}, member_id, tasks)
  end


  defp create_visit(pid, {available_mins, visit_mins}, member_id, tasks) when available_mins >= visit_mins do
    VisitMarketplace.VisitRepository.create_visit(pid, member_id, visit_mins, tasks)
  end

  defp create_visit(_pid, _, member_id, _) do
    {:error, "Member #{member_id} does not have enough minutes to create this visit}"}
  end

  def accept_visit(pid, member, pal, visit_id) do
    visit = VisitMarketplace.VisitRepository.
    VisitMarketplace.UserRepository.update_minutes(pid, member, pal, visit.minutes)
    |> create_transaction(pid, {member, pal, visit.visit_id})
  end

  defp create_transaction({:ok}, pid, {member_id, pal_id, visit_id}) do
    VisitMarketplace.TransactionRepository.create_transaction(pid, member_id, pal_id, visit_id)
  end
end
