# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

config :rsvp, Rsvp.Repo,
  database: "rsvp",
  username: "postgres",
  password: "postgres"

config :rsvp, ecto_repos: [Rsvp.Repo]