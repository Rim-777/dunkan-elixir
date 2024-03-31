defmodule Dunkan.Contexts.Users.FindOrCreateContextTest do
  use Dunkan.DataCase
  alias Dunkan.User
  alias Dunkan.Profile
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.FindOrCreateContext

  import Dunkan.UsersFixtures

  describe "find or create user by oauth attributes" do
    @email "dummy@test-mail.com"
    @displayed_name "Michael Jordan"
    @oauth_provider_uid_facebook "75cc3264-7c27-4877-a8bf-29605d98f762"
    @oauth_provider_uid_google "77cc7777-7c27-4877-a8bf-12345398f762"

    @attrs %{
      email: @email,
      password: "#Test1234567",
      profile: %{type: "player", displayed_name: @displayed_name},
      oauth_provider: %{name: "facebook", uid: @oauth_provider_uid_facebook}
    }

    test "by_oauth_attrs/1 finds a user by oauth provider attrs ignoring email" do
      user = user_fixture(%{email: "deliberately_wrong_email@test.com"})

      %User{
        id: user_id,
        profile: %Profile{id: profile_id},
        oauth_providers: [%OauthProvider{id: provider_id}]
      } = user

      assert %User{
               id: ^user_id,
               profile: %Profile{id: ^profile_id},
               oauth_providers: [%OauthProvider{id: ^provider_id}]
             } = FindOrCreateContext.by_oauth_attrs(@attrs)
    end

    test "by_oauth_attrs/1 finds a user by email" do
      user = user_fixture(%{email: @email})

      target_user =
        @attrs
        |> Map.replace(:oauth_provider, %{name: "google", uid: @oauth_provider_uid_google})
        |> FindOrCreateContext.by_oauth_attrs()

      %User{
        id: user_id,
        profile: %Profile{id: profile_id},
        oauth_providers: [%OauthProvider{name: :facebook}]
      } = user

      assert %User{
               id: ^user_id,
               email: @email,
               profile: %Profile{id: ^profile_id},
               oauth_providers: [
                 %OauthProvider{name: :facebook, uid: @oauth_provider_uid_facebook}
               ]
             } = target_user
    end
  end
end
