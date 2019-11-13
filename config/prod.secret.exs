# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
use Mix.Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :adoptoposs, Adoptoposs.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :adoptoposs, AdoptopossWeb.Endpoint,
  http: [:inet6, port: String.to_integer(System.get_env("PORT") || "4000")],
  secret_key_base: secret_key_base

github_client_id =
  System.get_env("GITHUB_CLIENT_ID") ||
    raise """
    environment variable GITHUB_CLIENT_ID is missing.
    See https://github.com/settings/apps
    """

github_client_secret =
  System.get_env("GITHUB_CLIENT_SECRET") ||
    raise """
    environment variable GITHUB_CLIENT_SECRET is missing.
    See https://github.com/settings/apps
    """

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: github_client_id,
  client_secret: github_client_secret

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#
#     config :adoptoposs, AdoptopossWeb.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.