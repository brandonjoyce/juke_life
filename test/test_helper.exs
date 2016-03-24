ExUnit.start

Mix.Task.run "ecto.create", ~w(-r JukeLife.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r JukeLife.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(JukeLife.Repo)

