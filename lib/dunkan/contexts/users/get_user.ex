defmodule Dunkan.Contexts.Users.GetUser do
  @moduledoc """
  The Users Get by ID context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.User
  alias Dunkan.OauthProvider

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user("test@email.com")
      %User{}

      iex> get_user("nonexis@email.com")
      nil
       
      iex> get_with_relations(id)

  """

  def by_email(email) do
    query =
      from user in User,
        preload: [:profile, :oauth_providers],
        where: user.email == ^email

    Repo.one(query)
  end

  @doc """
  Gets a single user with relations.

  returns nil if user not found.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)
       
      iex> get_with_relations(id)
      %User{profile: %Profile{}, oauth_providers: [%OauthProvider{}]}
  """

  def by_id(id) do
    query =
      from user in User,
        preload: [:profile, :oauth_providers],
        where: user.id == ^id

    Repo.one(query)
  end

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
