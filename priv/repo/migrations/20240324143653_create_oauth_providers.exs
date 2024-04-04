defmodule Dunkan.Repo.Migrations.CreateOauthProviders do
  use Ecto.Migration

  def change do
    create table(:oauth_providers, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :uid, :string
      add :user_id, references(:users, on_delete: :delete_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:oauth_providers, [:user_id])

    create unique_index(:oauth_providers, [:name, :uid])
  end
end
