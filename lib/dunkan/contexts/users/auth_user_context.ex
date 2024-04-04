defmodule Dunkan.Contexts.Users.AuthUserContext do
  alias Dunkan.Contexts.Users.FindOrCreateContext
  alias Dunkan.Contexts.Users.UpdateUserContext
  alias Dunkan.Contexts.Users.GetUserContext
  alias Dunkan.User
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.AuthUserContext.PasswordUtility
  alias Dunkan.Contexts.Users.AuthUserContext.Tokenizer

  def auth_with_oauth_provider(%{password: password, oauth_provider: provider_attrs} = attrs) do
    with {:ok, user} <- find_or_create_user(attrs) |> validate_password(password) do
      user
      |> add_new_provider_if_given(provider_attrs)
      |> Tokenizer.create_token(:access)
    end
  end

  def find_or_create_user(attrs) do
    FindOrCreateContext.by_oauth_attrs(attrs)
  end

  def add_new_provider_if_given(%User{oauth_providers: oauth_providers} = user, provider_attrs) do
    case provider_present?(oauth_providers, provider_attrs) do
      true ->
        user

      false ->
        {:ok, %OauthProvider{user_id: user_id}} =
          UpdateUserContext.add_oauth_provider(user, provider_attrs)

        GetUserContext.by_id(user_id)
    end
  end

  defp validate_password({:ok, %User{password: hashed_password} = user}, password) do
    case PasswordUtility.validate_password(password, hashed_password) do
      true -> {:ok, user}
      false -> {:error, :invalid_password}
    end
  end

  def provider_present?(oauth_providers, provider_attrs) do
    is_present? = fn provider ->
      to_string(provider.name) == to_string(provider_attrs.name)
    end

    oauth_providers
    |> Enum.any?(&is_present?.(&1))
  end
end
