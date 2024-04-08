defmodule Dunkan.Contexts.Users.AuthUserContext.Tokenizer do
  @moduledoc """
   Creates tokens using Guardian - authentication library
   https://hexdocs.pm/guardian/Guardian.html
  """

  @token_types [:access, :refresh, :admin]
  alias Dunkan.Contexts.Users.AuthUserContext.Guardian
  alias Dunkan.User

  @doc """
    1) Accepts a %User{} and token type atom
    2) Creates s JWT token
    4) Returns a tuple  

    Returns error if the record has not been stored

     ## Examples
      iex> create_token(%User{}, :access)
      {:ok, %User{}, jwt-token}
  """

  def create_token(%User{} = user, token_type) when token_type in @token_types do
    {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, token_options(token_type))

    {:ok, user, token}
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {180, :day}]
      :refresh -> [token_type: "refresh", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {365, :day}]
    end
  end
end
