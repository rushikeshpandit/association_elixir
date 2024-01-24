defmodule AssociationElixir.Repo.Migrations.CreateCompanies do
  use Ecto.Migration

  def change do
    create_query = "CREATE TYPE type AS ENUM ('SERVICE', 'PRODUCT')"
    drop_query = "DROP TYPE roles"

    execute(create_query, drop_query)

    create table(:companies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :description, :string
      add :type, :type, default: "SERVICE", null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:companies, [:name])
  end
end
