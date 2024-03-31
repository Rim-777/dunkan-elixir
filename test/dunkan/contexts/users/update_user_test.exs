defmodule Dunkan.Contexts.Users.UpdateUserTest do
  use Dunkan.DataCase
  import Ecto.Query, warn: false
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.UpdateUser
  alias Dunkan.Contexts.Users.GetUser

  describe "add_oauth_provider" do
    test "add_oauth_provider/1" do
      attrs = %{name: "google", uid: "some-uid-777777777"}

      user =
        %User{id: user_id, oauth_providers: [%OauthProvider{name: :facebook}]} = user_fixture()

      assert {:ok, %OauthProvider{user_id: ^user_id}} =
               UpdateUser.add_oauth_provider(user, attrs)

      assert [%OauthProvider{name: :google}, %OauthProvider{name: :facebook}] =
               GetUser.by_id(user_id).oauth_providers
    end
  end
end
