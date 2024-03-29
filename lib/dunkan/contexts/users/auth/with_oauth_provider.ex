# defmodule Dunkan.Contexts.Users.Auth.WithOauthProvider do
#   alias Dunkan.Contexts.Users.Get
#   alias Dunkan.Contexts.Users.Create
#   alias Dunkan.Contexts.Users.GetByEmail
#   alias Dunkan.User

#   def auth_user(attrs) do
#     find_user(attrs)
#     |> case do
#       nil ->
#         create_user(attrs)

#       user ->
#         auth_user(user, attrs.password)
#     end
#   end

# |> case do
#   %User{email: ^email} = user ->
#     UpdateUser.add_oauth_provider(user, provider_attrs)

#   _ ->
#     nil
# end

#   defp find_or_create_user(attrs) do
#     %{
#       oauth_provider: %{name: provider_name, uid: user_uid} = provider_attrs,
#       email: email,
#       password: password
#     } = attrs

#     find_user({email, provider_attrs}) || create_user(attrs)
#   end

#   defp find_user({email, provider_attrs}) do
#     find_user_by(provider_attrs) || find_user_by(email, provider_attrs)
#   end

#   defp find_user_by(%{name: _name, uid: _uid} = provider_attrs) do
#     Get.ByOauthProvider.get_user(provider_attrs)
#   end

#   defp find_user_by(email, provider_attrs) do
#     GetByEmail.get_with_relations(email)
#     |> case do
#       nil ->
#         nil

#       user ->
#         nil
#         # add provider to user 
#     end
#   end

#   defp auth_user(%User{password: hashed_password}, password) do
#     case Bcrypt.verify_pass(password, hashed_password) do
#       true -> "create_token(account, :access)"
#       false -> {:error, :unauthorized}
#     end
#   end

#   defp create_user(attrs) do
#     Create.WithRelations.create_user(attrs)
#   end
# end
