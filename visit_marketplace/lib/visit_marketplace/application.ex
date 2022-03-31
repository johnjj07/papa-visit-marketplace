defmodule VisitMarketplace.Application do
  use Application
  alias VisitMarketplace.{VisitRepository, UserRepository}

  def start(_type, _args) do
    children = [
      %{id: UserRepository,
        start: {UserRepository, :start_link, []}
      },
      %{id: VisitRepository,
        start: {VisitRepository, :start_link, []}
      }
    ]

    options = [
      name: VisitMarketplace.Supervisor,
      strategy: :one_for_one
    ]
    Supervisor.start_link(children, options)
  end
end
