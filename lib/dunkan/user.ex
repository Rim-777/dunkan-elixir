defmodule Dunkan.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dunkan.Profile
  alias Dunkan.OauthProvider
  alias Dunkan.Contexts.Users.AuthUserContext.PasswordUtility

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :email, :string
    field :password, :string
    field :phone_number, :string

    has_one :profile, Profile
    has_many :oauth_providers, OauthProvider

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:email, :password, :phone_number])
    |> cast_assoc(:profile)
    |> cast_assoc(:oauth_providers)
    |> validate_phone_number()
    |> validate_email()
    |> validate_password()
    |> put_password_hash()
  end

  defp validate_phone_number(changeset) do
    get_field(changeset, :email)
    |> case do
      nil ->
        changeset
        |> validate_required(:phone_number, message: "Phone number or Email required")
        |> validate_format(:phone_number, ~r/\A\+\d+\z/x, message: "Must begin with  +")

      _email ->
        changeset
    end
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i,
      message: "Invalid format"
    )
    |> validate_length(:email, max: 160, message: "Max length 160 symbols")
  end

  defp validate_password(changeset) do
    changeset
    |> validate_required([:password])
    |> validate_length(:password, min: 8, message: "Min length 8 symbols")
  end

  defp put_password_hash(%Ecto.Changeset{changes: %{password: password}} = changeset) do
    change(changeset, password: PasswordUtility.hash_password(password))
  end

  defp put_password_hash(changeset), do: changeset
end
