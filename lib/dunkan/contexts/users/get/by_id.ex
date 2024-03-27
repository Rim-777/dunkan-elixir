defmodule Dunkan.Contexts.Users.Get.ById do
  @moduledoc """
  The Users Get by ID context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.User

  @doc """
  Gets a single user.

  Raises `Ecto.NoResultsError` if the User does not exist.

  ## Examples

      iex> get_user!(123)
      %User{}

      iex> get_account!(456)
      ** (Ecto.NoResultsError)
       
      iex> get_with_relations(id)

  """
  def get_user!(id), do: Repo.get!(User, id)

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

  def get_with_relations(id) do
    query =
      from user in User,
        preload: [:profile, :oauth_providers],
        where: user.id == ^id

    Repo.one(query)
  end
end
