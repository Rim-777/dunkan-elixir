defmodule Dunkan.Contexts.Users.Auth.AuthUser do
  @token_types [:access, :reset, :admin]
  alias Dunkan.Contexts.Users.Auth.Guardian
  alias Dunkan.User
  alias Dunkan.Contexts.Users.Auth.PasswordUtility

  def exec(%User{password: hash_password} = user, password) do
    PasswordUtility.validate_password(password, hash_password)
    |> case do
      true -> create_token(user, :access)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(%User{} = user, token_type) when token_type in @token_types do
    {:ok, token, _claims} = Guardian.encode_and_sign(user, %{}, token_options(token_type))
    {:ok, user, token}
  end

  defp token_options(type) do
    case type do
      :access -> [token_type: "access", ttl: {90, :day}]
      :reset -> [token_type: "reset", ttl: {15, :minute}]
      :admin -> [token_type: "admin", ttl: {365, :day}]
    end
  end
end
