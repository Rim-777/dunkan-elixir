defmodule Dunkan.Contexts.Users.UpdateUserTest do
  use Dunkan.DataCase
  import Ecto.Query, warn: false
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.UpdateUser
  alias Dunkan.Contexts.Users.GetUser

  describe "add_oauth_provider" do
    @attrs %{name: "google", uid: "75cc3264-7c27-4877-a8bf-29605d98f777"}

    setup do
      {:ok, user: %User{oauth_providers: [%OauthProvider{name: :facebook}]} = user_fixture()}
    end

    test "add_oauth_provider/1", setup do
      user = %User{id: user_id} = setup[:user]

      assert {:ok, %OauthProvider{user_id: ^user_id}} =
               UpdateUser.add_oauth_provider(user, @attrs)

      assert [%OauthProvider{name: :facebook}, %OauthProvider{name: :google}] =
               GetUser.by_id(user_id).oauth_providers
    end

    test "add_oauth_provider/1 should not create duplications", setup do
      user = %User{id: user_id} = setup[:user]

      assert {:ok, %OauthProvider{user_id: ^user_id}} =
               UpdateUser.add_oauth_provider(user, @attrs)

      assert {:error,
              %Ecto.Changeset{
                errors: [
                  name:
                    {"Combination of Provider name and UID must be unique",
                     [validation: :unsafe_unique, fields: [:name, :uid]]}
                ]
              }} =
               UpdateUser.add_oauth_provider(user, @attrs)
    end
  end
end
