defmodule Dunkan.ProfileTest do
  use Dunkan.DataCase

  alias Dunkan.Profile

  describe "changeset" do
    @min_valid_attrs %{
      displayed_name: "Timo Moss",
      profile_type: "player"
    }
    test "changeset/2 is valid with minimum required attributes" do
      assert %Ecto.Changeset{
               changes: %{
                 displayed_name: "Timo Moss",
                 profile_type: :player
               },
               valid?: true
             } = Profile.changeset(%Profile{}, @min_valid_attrs)
    end

    test "changeset/2 with incorrect profile type" do
      incorrect_type_attrs = @min_valid_attrs |> Map.replace(:profile_type, :wrong_type)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [profile_type: {"is invalid", _reason}]
             } = Profile.changeset(%Profile{}, incorrect_type_attrs)
    end

    test "changeset/2 with missing displayed_name" do
      missing_displayed_name_attrs =
        @min_valid_attrs |> Map.replace(:displayed_name, nil)

      assert %Ecto.Changeset{
               valid?: false,
               errors: [displayed_name: {"can't be blank", [validation: :required]}]
             } = Profile.changeset(%Profile{}, missing_displayed_name_attrs)
    end
  end
end
