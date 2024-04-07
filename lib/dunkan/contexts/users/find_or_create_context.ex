defmodule Dunkan.Contexts.Users.FindOrCreateContext do
  @moduledoc """
   Context of finding or creating a user
  """

  alias Dunkan.Contexts.Users.GetUserContext
  alias Dunkan.Contexts.Users.CreateUserContext
  alias Dunkan.User

  @doc """
  1) Tries to find a user by a given oauth_provider attrs 
  - if user not found
  2) Tries to find a user by a given email, then creates a new OauthProvider and adds it to the User
  - if user not found
  3) Creates a new User with a Profile and OauthProvider

  Returns error in case of creation with invalid attributes

  ## Examples
  iex> by_oauth_attrs(valid params)
  {:ok, %User}

   iex> by_oauth_attrs(invalid params)
  {:error, %Ecto.Changeset{}}
  """

  def by_oauth_attrs(attrs) do
    %{
      oauth_provider: %{name: _provider_name, uid: _user_uid} = provider_attrs,
      email: email,
      password: _password
    } = attrs

    find_user({email, provider_attrs})
    |> case do
      nil ->
        create_user(attrs)

      %User{} = user ->
        {:ok, user}
    end
  end

  defp find_user({email, provider_attrs}) do
    find_by(provider_attrs) || find_by(email)
  end

  defp find_by(%{name: _name, uid: _uid} = provider_attrs) do
    GetUserContext.by_oauth_provider(provider_attrs)
  end

  defp find_by(email) do
    GetUserContext.by_email(email)
  end

  defp create_user(attrs) do
    CreateUserContext.create_with_relations(attrs)
  end
end
