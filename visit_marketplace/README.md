# VisitMarketplace

## Installation and Execution

The application can be run by running `mix compile` in the project and then running
`iex -S mix` to interact the API in `VisitMarketplace`.

```elixir
    pid = VisitMarketplace.start()
    VisitMarketplace.add_user(pid, "Jared", "Johnson", "j@j.com")
    VisitMarketplace.add_user(pid, "Jared2", "Johnson2", "j2@j.com")
    visit = VisitMarketplace.create_visit(pid, "j@j.com", 10, ["task1", "task2"])
    transaction = VisitMarketplace.accept_visit(pid, "j@j.com", "j2@j.com", visit.id)
```

*NOTE: The application in its current state does not start due to an issue I have
yet to diagnose with the Supervision tree and an issue with the child specs.*

## Design Choices
I chose to use GenServers for the storage of the application data to exclude any
requirements of needing a database or external storage mechanism. I considered using
Erlang Term Storage (ETS), but I am less familiar with that and decided against it
due to time.

Normally I would perform TDD and have written unit tests, but since time has been hard
to come by I decided to eschew tests for the time being.

I purposefully kept `visit_marketplace` small, and only concerned myself with the interaction
of the data, and storage. The goal was to then use the API in `VisitMarketplace` to drive
another project, so that we only wrote the core logic once. We could write a CLI implementaton,
run a simple `Cowboy` web server, or go to `Phoenix`. Given more time I would have probably
considered making the external API for the repositories into `behaviors` to allow easier migration
to different data stores like an external database.

## Assumptions
I assumed that when a user was created that they would receive 60 minutes. If that did not happen
then all created users would have zero minutes and would not be able to create any visits.

I also chose to round down the minutes that were rewarded to the pal.