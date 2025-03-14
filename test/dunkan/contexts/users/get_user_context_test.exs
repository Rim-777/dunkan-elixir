defmodule Dunkan.Contexts.Users.GetUserContextTest do
  use Dunkan.DataCase
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.Profile
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.GetUserContext

  describe "getting users" do
    @email "dummy@test-mail.com"

    defmacrop ok_user(user_id) do
      quote do
        %User{
          id: ^unquote(user_id),
          email: @email,
          password: _password,
          phone_number: nil,
          profile: %Profile{
            first_name: nil,
            last_name: nil,
            middle_name: nil,
            displayed_name: "Michael Jordan",
            gender: nil,
            profile_type: :player
          },
          oauth_providers: [
            %OauthProvider{
              name: :facebook,
              uid: "75cc3264-7c27-4877-a8bf-29605d98f762"
            }
          ]
        }
      end
    end

    test "by_id/1 returns a stored user with its relations" do
      %User{id: id} = user_fixture(%{email: @email})

      assert ok_user(id) = GetUserContext.by_id(id)
    end

    test "by_oauth_provider/1 returns a stored user with its relations" do
      %User{id: id} = user_fixture(%{email: @email})

      assert assert ok_user(id) =
                      GetUserContext.by_oauth_provider(%{
                        name: :facebook,
                        uid: "75cc3264-7c27-4877-a8bf-29605d98f762"
                      })
    end

    test "by_email/1 returns a stored user with its relations" do
      %User{id: id} = user_fixture(%{email: @email})

      assert assert ok_user(id) = GetUserContext.by_email(@email)
    end
  end
end
