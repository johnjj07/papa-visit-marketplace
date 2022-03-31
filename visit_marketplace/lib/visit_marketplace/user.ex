defmodule VisitMarketplace.User do
  alias VisitMarketplace.User

  @enforce_keys [:email, :first_name, :last_name, :minutes]
  defstruct [:email, :first_name, :last_name, :minutes]

  def create(email, first_name, last_name) do
    %User{email: email, first_name: first_name, last_name: last_name, minutes: 60}
  end

  def is_valid?(email), do: true
end
