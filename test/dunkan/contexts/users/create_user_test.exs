defmodule Dunkan.Contexts.Users.CreateUserTest do
  use Dunkan.DataCase
  alias Dunkan.User
  alias Dunkan.Profile
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.CreateUser

  describe "with_relation" do
    @email "dummy@test-mail.com"
    @displayed_name "Michael Jordan"
    @oauth_provider_uid "75cc3264-7c27-4877-a8bf-29605d98f762"

    @attributes %{
      email: @email,
      password: "#Test1234567",
      profile: %{type: "player", displayed_name: @displayed_name},
      oauth_provider: %{name: "facebook", uid: @oauth_provider_uid}
    }

    test "Create.with_relation/1 creates a user with relations" do
      assert {:ok,
              %User{
                id: _user_id,
                email: @email,
                password: _hashed_password,
                phone_number: nil,
                profile: %Profile{
                  id: _profile_id,
                  first_name: nil,
                  last_name: nil,
                  middle_name: nil,
                  displayed_name: @displayed_name,
                  gender: nil,
                  type: :player
                },
                oauth_providers: [
                  %OauthProvider{
                    id: _provider_id,
                    name: :facebook,
                    uid: @oauth_provider_uid
                  }
                ]
              }} = CreateUser.with_relations(@attributes)
    end
  end
end
