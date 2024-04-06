defmodule Dunkan.Contexts.Users.UpdateUserTest do
  use Dunkan.DataCase
  import Ecto.Query, warn: false
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.UpdateUserContext
  alias Dunkan.Contexts.Users.GetUserContext

  describe "add_oauth_provider" do
    @attrs %{name: "google", uid: "75cc3264-7c27-4877-a8bf-29605d98f777"}

    setup do
      {:ok, user: %User{oauth_providers: [%OauthProvider{name: :facebook}]} = user_fixture()}
    end

    defmacro ok_oauth_provider(user_id) do
      quote do
        {:ok, %OauthProvider{user_id: ^unquote(user_id)}}
      end
    end

    test "add_oauth_provider/1", setup do
      user = %User{id: user_id} = setup[:user]

      assert ok_oauth_provider(user_id) = UpdateUserContext.add_oauth_provider(user, @attrs)

      assert [%OauthProvider{name: :facebook}, %OauthProvider{name: :google}] =
               GetUserContext.by_id(user_id).oauth_providers
    end

    test "add_oauth_provider/1 should not create duplications", setup do
      user = %User{id: user_id} = setup[:user]

      assert ok_oauth_provider(user_id) = UpdateUserContext.add_oauth_provider(user, @attrs)

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  name:
                    {"Combination of Provider name and UID must be unique",
                     [validation: :unsafe_unique, fields: [:name, :uid]]}
                ]
              }} =
               UpdateUserContext.add_oauth_provider(user, @attrs)
    end
  end
end
