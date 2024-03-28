# defmodule Dunkan.Contexts.Users.FindOrCreateUser do
#   def exec(attrs) do
#     %{
#       oauth_provider: %{name: provider_name, uid: user_uid} = provider_attrs,
#       email: email,
#       hash_password: hash_password
#     } = attrs

#     find_user({email, provider_attrs}) || create_user(attrs)
#   end

#   def find_user({email, provider_attrs}) do
#     find_user_by(provider_attrs) || find_user_by(email, provider_attrs)
#   end

#   def find_user_by(%{name: _name, uid: _uid} = provider_attrs) do
#     Get.ByOauthProvider.get_user(provider_attrs)
#   end

#   def find_user_by(email, provider_attrs) do
#     GetByEmail.get_with_relations(email)
#     |> case do
#       nil ->
#         nil

#       user ->
#         nil
#         # add provider to user 
#     end
#   end
# end
