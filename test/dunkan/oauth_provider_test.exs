defmodule Dunkan.OauthProviderTest do
  use Dunkan.DataCase

  alias Dunkan.OauthProvider

  describe "oauth_provider changeset" do
    @valid_attrs %{
      name: "google",
      uid: "qw123fsdsd122312hd"
    }

    @invalid_attrs %{
      name: "incorrect",
      uid: nil
    }

    @changes %{
      name: :google,
      uid: "qw123fsdsd122312hd"
    }

    test "changeset/2 returns valid oauth_provider changeset" do
      assert %Ecto.Changeset{
               changes: @changes,
               valid?: true
             } = OauthProvider.changeset(%OauthProvider{}, @valid_attrs)
    end

    test "changeset/2 returns invalid changeset when provider name is invalid" do
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
