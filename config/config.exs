import Config

config :logger, level: :info

# DB
config :blog,
  ecto_repos: [Blog.Repo]

config :blog, Blog.Repo,
  database: "blog_dev",
  port: 5433,
  username: "blogadmin",
  password: "blogadmin",
  hostname: "localhost"

config :blog, Blog.Repo,
  migration_primary_key: [type: :binary_id],
  migration_timestamps: [type: :utc_datetime]
