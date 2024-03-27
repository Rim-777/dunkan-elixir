defmodule Dunkan.OauthProviders do
  @moduledoc """
  The OauthProviders context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.OauthProvider

  @doc """
  Returns the list of oauth_providers.

  ## Examples

      iex> list_oauth_providers()
      [%OauthProvider{}, ...]

  """
  def list_oauth_providers do
    Repo.all(OauthProvider)
  end

  @doc """
  Gets a single oauth_provider.

  Raises `Ecto.NoResultsError` if the Oauth provider does not exist.

  ## Examples

      iex> get_oauth_provider!(123)
      %OauthProvider{}

      iex> get_oauth_provider!(456)
      ** (Ecto.NoResultsError)

  """
  def get_oauth_provider!(id), do: Repo.get!(OauthProvider, id)

  @doc """
  Creates a oauth_provider.

  ## Examples

      iex> create_oauth_provider(%{field: value})
      {:ok, %OauthProvider{}}

      iex> create_oauth_provider(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_oauth_provider(attrs \\ %{}) do
    %OauthProvider{}
    |> OauthProvider.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a oauth_provider.

  ## Examples

      iex> update_oauth_provider(oauth_provider, %{field: new_value})
      {:ok, %OauthProvider{}}

      iex> update_oauth_provider(oauth_provider, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_oauth_provider(%OauthProvider{} = oauth_provider, attrs) do
    oauth_provider
    |> OauthProvider.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a oauth_provider.

  ## Examples

      iex> delete_oauth_provider(oauth_provider)
      {:ok, %OauthProvider{}}

      iex> delete_oauth_provider(oauth_provider)
      {:error, %Ecto.Changeset{}}

  """
  def delete_oauth_provider(%OauthProvider{} = oauth_provider) do
    Repo.delete(oauth_provider)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking oauth_provider changes.

  ## Examples

      iex> change_oauth_provider(oauth_provider)
      %Ecto.Changeset{data: %OauthProvider{}}

  """
  def change_oauth_provider(%OauthProvider{} = oauth_provider, attrs \\ %{}) do
    OauthProvider.changeset(oauth_provider, attrs)
  end
end
