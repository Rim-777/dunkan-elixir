defmodule Dunkan.Contexts.Users.CreateUserContext do
  @moduledoc """
  The context of Users creation with relations such as %Profile and OauthProviders
  """

  import Ecto.Query, warn: false
  alias Dunkan.Repo
  alias Dunkan.User

  @doc """
    1) Accepts combined attributes of user and related Profile and Oauth attributes
    2) Rebuilds params according to the Changesets
    3) Inserts a user and relations to the database 
    4) Returns a %User with all relations 

    Returns error if the record has not been stored

     ## Examples

      
     valid_attrs = %{
      email: @email,
      password: "#Test1234567",
      profile: %{profile_type: "player", displayed_name: @displayed_name},
      oauth_provider: %{name: "facebook", uid: @oauth_provider_uid}
    }
      iex> auth_with_oauth_provider(valid_attrs)
      {:ok, %User{profile: %Profile{}, oauth_providers: [%OauthProvider{}]}}

       iex> auth_with_oauth_provider(invalid params)
      {:error, %Ecto.Changeset{}}
  """

  def create_with_relations(attrs \\ %{}) do
    attrs = build_attrs(attrs)

    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp build_attrs(attrs) do
    {auth_provider, rest_attrs} = Map.pop(attrs, :oauth_provider)

    rest_attrs
    |> Map.put(:oauth_providers, [auth_provider])
  end
end
