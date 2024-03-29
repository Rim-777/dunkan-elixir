defmodule Dunkan.Contexts.Users.FindOrCreateUser do
  alias Dunkan.Contexts.Users.GetUser
  alias Dunkan.Contexts.Users.UpdateUser
  alias Dunkan.Contexts.Users.CreateUser
  alias Dunkan.User

  def call(attrs) do
    %{
      oauth_provider: %{name: _provider_name, uid: _user_uid} = provider_attrs,
      email: email,
      hash_password: _hash_password
    } = attrs

    find_user({email, provider_attrs}) || create_user(attrs)
  end

  defp find_user({email, provider_attrs}) do
    find_by_oauth_provider(provider_attrs) ||
      find_by_email_add_oauth_provider(email, provider_attrs)
  end

  defp find_by_oauth_provider(%{name: _name, uid: _uid} = provider_attrs) do
    GetUser.by_oauth_provider(provider_attrs)
  end

  defp find_by_email_add_oauth_provider(email, provider_attrs) do
    GetUser.by_email(email)
    |> case do
      %User{email: ^email} = user ->
        UpdateUser.add_oauth_provider(user, provider_attrs)

      _ ->
        nil
    end
  end

  defp create_user(attrs) do
    CreateUser.with_relations(attrs)
  end
end
