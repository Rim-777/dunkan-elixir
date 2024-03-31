defmodule Dunkan.Contexts.Users.AuthUserContext.Tokenizer do
  @token_types [:access, :refresh, :admin]
  alias Dunkan.Contexts.Users.AuthUser.Guardian
  alias Dunkan.User

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
