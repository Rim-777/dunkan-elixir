defmodule Dunkan.Contexts.Users.FindOrCreateContext do
  alias Dunkan.Contexts.Users.GetUser
  alias Dunkan.Contexts.Users.CreateUserContext
  alias Dunkan.User

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

    # add transaction with lock
  end

  defp find_user({email, provider_attrs}) do
    find_by(provider_attrs) || find_by(email)
  end

  defp find_by(%{name: _name, uid: _uid} = provider_attrs) do
    GetUser.by_oauth_provider(provider_attrs)
  end

  defp find_by(email) do
    GetUser.by_email(email)
  end

  defp create_user(attrs) do
    CreateUserContext.create_with_relations(attrs)
  end
end
