defmodule Dunkan.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Dunkan.User

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    field :displayed_name, :string
    field :photo_url, :string
    field :date_of_birth, :string
    field :gender, Ecto.Enum, values: [:male, :female, :other]
    field :profile_type, Ecto.Enum, values: [:player, :fun, :parent, :club, :trainer]

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [
      :first_name,
      :last_name,
      :middle_name,
      :displayed_name,
      :photo_url,
      :date_of_birth,
      :gender,
      :profile_type
    ])
    |> validate_required([:displayed_name])
    |> validate_date_of_birth()
  end

  defp validate_date_of_birth(changeset) do
    changeset
    |> validate_format(:date_of_birth, ~r/^\d{4}\-(0[1-9]|1[012])\-(0[1-9]|[12][0-9]|3[01])$/,
      message: "Invalid format, must be exactly in format yyyy-mm-dd"
    )
  end
end
