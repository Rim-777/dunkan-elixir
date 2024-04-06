defmodule Dunkan.Contexts.Users.UpdateUserContext do
  @moduledoc """
  The update User context.
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo

  alias Dunkan.User
  alias Dunkan.OauthProvider

  @doc """
  Takes an existing user and oauth provider attributes as params
  Creates and adds a new oauth provider such a google, facebook, etc, to the given user

  returns error if the record is not stored

  ## Examples
      iex> add_oauth_provider(valid params)
      {:ok, %OauthProvider{}}

       iex> add_oauth_provider(invalid params)
      {:error, %Ecto.Changeset{}}
  """

  def add_oauth_provider(%User{id: user_id}, %{name: _name, uid: _uid} = provider_attrs) do
    %OauthProvider{user_id: user_id}
    |> OauthProvider.changeset(provider_attrs)
    |> Repo.insert()
  end
end
