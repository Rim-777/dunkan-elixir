defmodule Dunkan.Contexts.Users.AuthUserContext do
  @moduledoc """
   authenticate users by oauth providers
  """

  alias Dunkan.Contexts.Users.FindOrCreateContext
  alias Dunkan.Contexts.Users.UpdateUserContext
  alias Dunkan.Contexts.Users.GetUserContext
  alias Dunkan.User
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.AuthUserContext.PasswordUtility
  alias Dunkan.Contexts.Users.AuthUserContext.Tokenizer

  @doc """
   1) Finds or creates a user 
   2) Validates a given password
   3) Creates a a JWT token

   Returns error if the record has not been stored or password is invalid

     ## Examples
      iex> auth_with_oauth_provider(valid params)
      {:ok, %User, token}

       iex> auth_with_oauth_provider(invalid params)
      {:error, %Ecto.Changeset{}}

      iex> auth_with_oauth_provider(invalid password in params)
      {:error, :invalid_password}
  """

  def auth_with_oauth_provider(%{password: password, oauth_provider: provider_attrs} = attrs) do
    with {:ok, user} <- find_or_create_user(attrs),
         {:ok, ^user} <- validate_password(user, password) do
      user
      |> add_new_provider_if_given(provider_attrs)
      |> Tokenizer.create_token(:access)
    end
  end

  defp find_or_create_user(attrs) do
    FindOrCreateContext.by_oauth_attrs(attrs)
  end

  defp add_new_provider_if_given(%User{oauth_providers: oauth_providers} = user, provider_attrs) do
    case provider_present?(oauth_providers, provider_attrs) do
      true ->
        user

      false ->
        {:ok, %OauthProvider{user_id: user_id}} =
          UpdateUserContext.add_oauth_provider(user, provider_attrs)

        GetUserContext.by_id(user_id)
    end
  end

  defp validate_password(%User{password: hashed_password} = user, password) do
    case PasswordUtility.valid_password?(password, hashed_password) do
      true -> {:ok, user}
      false -> {:error, :invalid_password}
    end
  end

  defp provider_present?(oauth_providers, provider_attrs) do
    is_present? = fn provider ->
      to_string(provider.name) == to_string(provider_attrs.name)
    end

    oauth_providers
    |> Enum.any?(&is_present?.(&1))
  end
end
