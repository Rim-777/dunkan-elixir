defmodule Dunkan.Contexts.Users.GetUserTest do
  use Dunkan.DataCase
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.Profile
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.GetUser

  describe "getting users by id" do
    @email "dummy@test-mail.com"
    test "by_id/1 returns a stored user with its relations" do
      %User{id: id} = user_fixture(%{email: @email})

      assert %Dunkan.User{
               id: ^id,
               email: @email,
               password: _password,
               phone_number: nil,
               profile: %Profile{
                 first_name: nil,
                 last_name: nil,
                 middle_name: nil,
                 displayed_name: "Michael Jordan",
                 gender: nil,
                 type: :player
               },
               oauth_providers: [
                 %OauthProvider{
                   name: :facebook,
                   uid: "75cc3264-7c27-4877-a8bf-29605d98f762"
                 }
               ]
             } = GetUser.by_id(id)
    end
  end
end
