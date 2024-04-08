defmodule Dunkan.Repo.Migrations.CreateProfiles do
  use Ecto.Migration

  def change do
    create table(:profiles, primary_key: false) do
      add :id, :binary_id, primary_key: true

      add :first_name, :string
      add :last_name, :string
      add :middle_name, :string
      add :displayed_name, :string
      add :gender, :string
      add :profile_type, :string
      add :photo_url, :string
      add :date_of_birth, :string

      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:profiles, [:user_id])
    create index(:profiles, [:displayed_name, :date_of_birth, :gender])
  end
end
