Mix.Task.run "ecto.create"
Mix.Task.run "ecto.migrate"

ExActivity.Repo.start_link()
Ecto.Adapters.SQL.Sandbox.mode(ExActivity.Repo, {:shared, self()})

ExUnit.start()
