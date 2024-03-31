defmodule Dunkan.UserTest do
  use Dunkan.DataCase

  alias Dunkan.User
  alias Dunkan.Contexts.Users.AuthUserContext.PasswordUtility

  describe "user changeset" do
    @profile_attrs %{displayed_name: "Michael Jordan", type: :player}

    @valid_email "test.check.@email.co"
    @invalid_email "test.check.@email"
    @valid_password "12345678"
    @invalid_password "1234567"
    @valid_phone_number "+31680213398"
    @invalid_phone_number "123457543"

    @oauth_providers_attrs %{name: "google", uid: "1234"}
    @oauth_providers_change %{name: :google, uid: "1234"}

    @valid_attrs %{
      email: @valid_email,
      password: @valid_password,
      profile: @profile_attrs,
      oauth_providers: [@oauth_providers_attrs]
    }

    test "changeset/2 returns valid user changeset with hashed password and relations" do
      assert %Ecto.Changeset{
               changes: %{
                 email: @valid_email,
                 password: hashed_password,
                 profile: %Ecto.Changeset{
                   changes: @profile_attrs,
                   valid?: true
                 },
                 oauth_providers: [
                   %Ecto.Changeset{changes: @oauth_providers_change, valid?: true}
                 ]
               },
               valid?: true
             } = User.changeset(%User{}, @valid_attrs)

      assert PasswordUtility.validate_password(@valid_attrs.password, hashed_password) ==
               true
    end

    test "changeset/2 returns valid user changeset without oauth_providers" do
      assert attrs = Map.reject(@valid_attrs, fn {k, _v} -> k == :oauth_providers end)

      assert %Ecto.Changeset{
               changes: %{
                 profile: %Ecto.Changeset{
                   changes: @profile_attrs,
                   valid?: true
                 }
               },
               valid?: true
             } = User.changeset(%User{}, attrs)
    end

    test "changeset/2 returns valid user changeset without relations" do
      attrs = Map.reject(@valid_attrs, fn {k, _v} -> k == :oauth_providers or k == :profile end)

      assert %Ecto.Changeset{
               valid?: true
             } = User.changeset(%User{}, attrs)
    end

    test "changeset/2 returns valid user changeset with phone_number instead email" do
      attrs =
        @valid_attrs
        |> Map.reject(fn {k, _v} -> k == :email end)
        |> Map.merge(%{phone_number: @valid_phone_number})

      assert %Ecto.Changeset{
               changes: %{phone_number: @valid_phone_number},
               valid?: true
             } = User.changeset(%User{}, attrs)
    end

    test "changeset/2 returns error if email or phone_number missing" do
      invalid_attrs = %{password: @valid_password}

      assert %Ecto.Changeset{
               valid?: false,
               errors: [phone_number: {"Phone number or Email required", [validation: :required]}]
             } = User.changeset(%User{}, invalid_attrs)
    end

    test "changeset/2 returns error if email or phone_number invalid format" do
      invalid_attrs = %{password: @valid_password, phone_number: @invalid_phone_number}

      assert %Ecto.Changeset{
               valid?: false,
               errors: [
                 phone_number: {"Must begin with  +", [validation: :format]}
               ]
             } = User.changeset(%User{}, invalid_attrs)
    end

    test "changeset/2 returns error if email has invalid format" do
      invalid_attrs = %{password: @valid_password, email: @invalid_email}

      assert %Ecto.Changeset{
               valid?: false,
               errors: [email: {"Invalid format", [validation: :format]}]
             } = User.changeset(%User{}, invalid_attrs)
    end

    test "changeset/2 returns error if password is missing" do
      invalid_attrs = %{email: @valid_email}

      assert %Ecto.Changeset{
               valid?: false,
               errors: [password: {"can't be blank", [validation: :required]}]
             } = User.changeset(%User{}, invalid_attrs)
    end

    test "changeset/2 returns error if password is too short" do
      invalid_attrs = %{email: @valid_email, password: @invalid_password}

      assert %Ecto.Changeset{
               valid?: false,
               errors: [
                 password:
                   {"Min length 8 symbols",
                    [count: 8, validation: :length, kind: :min, type: :string]}
               ]
             } = User.changeset(%User{}, invalid_attrs)
    end
  end
end
