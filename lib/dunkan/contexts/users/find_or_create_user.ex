# defmodule Dunkan.Contexts.Users.FindOrCreateUser do
#   alias Dunkan.Contexts.Users.GetUser
#   alias Dunkan.Contexts.Users.UpdateUser

#   def call(attrs) do
#     %{
#       oauth_provider: %{name: _provider_name, uid: _user_uid} = provider_attrs,
#       email: email,
#       hash_password: _hash_password
#     } = attrs

#     find_user({email, provider_attrs}) || create_user(attrs)
#   end

#   def find_user({email, provider_attrs}) do
#     find_user_by(provider_attrs) || find_user_by(email, provider_attrs)
#   end

#   def find_user_by(%{name: _name, uid: _uid} = provider_attrs) do
#     GetUser.by_oauth_provider(provider_attrs)
#   end

#   def find_user_by(email, provider_attrs) do
#     GetUser.by_email(email)
#     |> case do
#       nil ->
#         nil

#       user ->
#         UpdateUser.add_oauth_provider(user)
#     end
#   end
# end
