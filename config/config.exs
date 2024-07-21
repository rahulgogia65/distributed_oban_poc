import Config

config :oban_poc, ObanPoc.Repo,
  database: "oban_poc_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :oban_poc, ecto_repos: [ObanPoc.Repo]

config :oban_poc, Oban,
  engine: Oban.Engines.Basic,
  queues: [default: 2],
  peer: Oban.Peers.Postgres,
  repo: ObanPoc.Repo

# config :oban_poc, Oban, testing: :inline

config :oban_poc, Oban,
  plugins: [
    {Oban.Plugins.Cron,
      crontab: [
        {"@daily", ObanPoc.Periodic.FileFetcher, max_attempts: 3}
      ]}
  ]
