defmodule Dunkan.Contexts.Users.Auth.AuthOrCreateUser do
  alias Dunkan.Contexts.Users.Get
  alias Dunkan.Contexts.Users.Create
  alias Dunkan.User

  def auth_user(full_attrs) do
    %{
      oauth_provider: provider_data,
      user: %{email: _email, hash_password: hash_password}
    } = full_attrs

    Get.ByOauthProvider.get_user(provider_data)
    |> case do
      nil -> create_and_authenticate(full_attrs)
      user -> auth_user(user, hash_password)
    end
  end

  defp auth_user(%User{hash_password: hash_password}, password) do
    case Bcrypt.verify_pass(password, hash_password) do
      true -> "create_token(account, :access)"
      false -> {:error, :unauthorized}
    end
  end

  defp create_and_authenticate(attrs) do
    Create.WithRelations.create_user(attrs)
    |> auth_user()
  end
end

# %{
#   :profile => %{
#     type: "my love",
#     first_name: "Tanechka",
#     last_name: "Moss",
#     gender: "female"
#   },
#   :email => "tanya@email.test",
#   :hash_password => "12345678",
#   oauth_provider: %{name: "google", uid: "123"}
# }
