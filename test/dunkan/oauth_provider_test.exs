defmodule Dunkan.OauthProviderTest do
  use Dunkan.DataCase

  alias Dunkan.OauthProvider

  describe "oauth_provider changeset" do
    @some_uid "75cc3264-7c27-4877-a8bf-29605d98f762"

    @valid_attrs %{
      name: "google",
      uid: @some_uid
    }

    @invalid_attrs %{
      name: "incorrect",
      uid: nil
    }

    @changes %{
      name: :google,
      uid: @some_uid
    }

    test "changeset/2 returns valid oauth_provider changeset" do
      assert %Ecto.Changeset{
               changes: @changes,
               valid?: true
             } = OauthProvider.changeset(%OauthProvider{}, @valid_attrs)
    end

    test "changeset/2 returns invalid changeset when name is invalid or uid missing" do
      assert %Ecto.Changeset{
               errors: [
                 uid: {"can't be blank", [validation: :required]},
                 name: {"is invalid", _reason}
               ],
               valid?: false
             } = OauthProvider.changeset(%OauthProvider{}, @invalid_attrs)
    end
  end
end
