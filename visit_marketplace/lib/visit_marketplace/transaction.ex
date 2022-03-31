defmodule VisitMarketplace.Transaction do
  alias VisitMarketplace.Transaction
  @enforce_keys [:member, :pal, :visit]
  defstruct [:member, :pal, :visit]

  def create(member, pal, visit) do
    %Transaction{member: member, pal: pal, visit: visit}
  end
end
