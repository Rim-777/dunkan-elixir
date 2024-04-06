defmodule Dunkan.Contexts.Users.GetUserContext do
  @moduledoc """
  The Users Get context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo
  alias Dunkan.User
  alias Dunkan.OauthProvider

  @doc """
   Gets a single user with related profile and oauth_providers by email.

   returns nil if the User does not exist.

   ## Examples

    iex> by_email("test@email.com")
    %User{email: "test@test.com"...}, profile: %Profile{displayed name: "Michel"}}, ...

    iex> by_email("nonexis@email.com")
    nil      
  """

  def by_email(email) do
    query =
      from user in User,
        preload: [:profile, :oauth_providers],
        where: user.email == ^email

    Repo.one(query)
  end

  @doc """
   Gets a single user with related profile and oauth_providers by id.

   returns nil if the User does not exist.

   ## Examples

    iex> by_id("123")
    %User{email: "test@test.com"...}, profile: %Profile{displayed name: "Michel"}}, ...

    iex> by_id("123456")
    nil      
  """

  def by_id(id) do
    query =
      from user in User,
        preload: [:profile, :oauth_providers],
        where: user.id == ^id

    Repo.one(query)
  end

  @doc """
   Gets a single user with related profile and oauth_providers by oauth_provider attributes.

   returns nil if the User does not exist.

   ## Examples

    iex> by_oauth_provider(%{name: "google", uid: "12312312312312"})
     %User{email: "test@test.com"...}, profile: %Profile{displayed name: "Michel"}}, ...

     iex> by_oauth_provider(%{name: "new-provider", uid: "7777777777777"})
     nil      
  """

  def by_oauth_provider(%{name: provider_name, uid: user_uid}) do
    query =
      from user in User,
        join: oauth_provider in OauthProvider,
        preload: [:profile, :oauth_providers],
        where: oauth_provider.name == ^provider_name and oauth_provider.uid == ^user_uid

    Repo.one(query)
  end

  @doc """
  Returns the list of users with relations.

  ## Examples

    iex> list_accounts()
    [%User{email: "test@test.com"...}, profile: %Profile{displayed name: "Michel"}}, ...]

  """

  def list_users do
    query = from user in User, preload: [:profile, :oauth_providers]
    Repo.all(query)
  end
end
