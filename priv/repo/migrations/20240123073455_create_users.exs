defmodule AssociationElixir.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE roles AS ENUM ('USER', 'ADMIN', 'SUPER_ADMIN')"
    drop_query = "DROP TYPE roles"

    execute(create_query, drop_query)

    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string
      add :user_name, :string
      add :password, :string
      add :password_confirmation, :string
      add :password_hash, :string
      add :email, :string
      add :role, :roles, default: "USER", null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
    create unique_index(:users, [:user_name])
  end
end
