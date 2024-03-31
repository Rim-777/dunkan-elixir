defmodule Dunkan.Contexts.Users.AuthUserContext.TokenizerTest do
  use Dunkan.DataCase
  alias Dunkan.Contexts.Users.AuthUserContext.Tokenizer
  alias Dunkan.User

  import Dunkan.UsersFixtures

  describe "issuing token" do
    test "create_token/2 returns {:ok, user, token}" do
      user = user_fixture()

      assert {:ok, %User{}, token} =
               Tokenizer.create_token(user, :refresh)

      assert(
        String.match?(token, ~r/^[A-Za-z0-9\-_=]+\.[A-Za-z0-9\-_=]+\.?[A-Za-z0-9\-_.+\/=]*$/)
      )
    end
  end
end
