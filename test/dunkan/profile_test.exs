defmodule Dunkan.ProfileTest do
  use Dunkan.DataCase

  # alias Dunkan.User
  alias Dunkan.Profile

  describe "changeset" do
    @min_attrs %{
      displayed_name: "Timo Moss",
      type: "player"
    }
    test "changeset/2 is valid with minimum required attributes" do
      assert %Ecto.Changeset{
               changes: %{
                 displayed_name: "Timo Moss",
                 type: :player
               },
               valid?: true
             } = Profile.changeset(%Profile{}, @min_attrs)
    end
  end
end
