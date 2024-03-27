defmodule Dunkan.Profile do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "profiles" do
    field :first_name, :string
    field :last_name, :string
    field :middle_name, :string
    field :displayed_name, :string
    field :gender, Ecto.Enum, values: [:male, :female, :other]
    field :type, Ecto.Enum, values: [:player, :fun, :parent, :club, :trainer]

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(profile, attrs) do
    profile
    |> cast(attrs, [:first_name, :last_name, :middle_name, :displayed_name, :gender, :type])
    |> validate_required([:displayed_name, :type])
  end
end
