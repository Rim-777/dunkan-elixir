defmodule Dunkan.Contexts.Users.AuthUserContextTest do
  use Dunkan.DataCase

  alias Dunkan.User
  alias Dunkan.Contexts.Users.AuthUserContext.Guardian
  alias Dunkan.Contexts.Users.AuthUserContext
  alias Dunkan.Contexts.Users.UpdateUserContext

  import Dunkan.UsersFixtures
  import Mock

  describe("auth user with oauth provider such as google an facebook") do
    @email "dummy@test-mail.com"
    @displayed_name "Michael Jordan"
    @oauth_provider_uid "75cc3264-7c27-4877-a8bf-29605d98f762"

    @attrs %{
      email: @email,
      password: "#Test1234567",
      profile: %{type: "player", displayed_name: @displayed_name},
      oauth_provider: %{name: "facebook", uid: @oauth_provider_uid}
    }

    @attrs_with_new_provider Map.replace(@attrs, :oauth_provider, %{
                               name: "google",
                               uid: @oauth_provider_uid
                             })

    test_with_mock "auth_with_oauth_provider/1 does not add a new oauth",
                   UpdateUserContext,
                   [:passthrough],
                   [] do
      assert {:ok, %User{id: user_id}, token} =
               AuthUserContext.auth_with_oauth_provider(@attrs)

      assert_not_called(UpdateUserContext.add_oauth_provider(:_, :_))
      assert {:ok, _} = Guardian.decode_and_verify(token, %{typ: "access", sub: user_id})
    end

    test_with_mock "auth_with_oauth_provider/1 adds a new oauth provider",
                   UpdateUserContext,
                   [:passthrough],
                   [] do
      user = %User{id: user_id} = user_fixture(%{email: @email})

      assert {:ok, %User{id: ^user_id}, token} =
               AuthUserContext.auth_with_oauth_provider(@attrs_with_new_provider)

      assert_called(
        UpdateUserContext.add_oauth_provider(user, %{name: "google", uid: @oauth_provider_uid})
      )

      assert {:ok, _} = Guardian.decode_and_verify(token, %{typ: "access", sub: user_id})
    end
  end
end
