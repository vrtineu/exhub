ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(Exhub.Repo, :manual)

Mox.defmock(Exhub.GithubApi.ClientMock, for: Exhub.GithubApi.Behaviour)
