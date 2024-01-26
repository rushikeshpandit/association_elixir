defmodule AssociationElixir.Repo.Migrations.CreateEmployees do
  use Ecto.Migration

  def change do
    create table(:employees, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :first_name, :string
      add :last_name, :string

      add :company_id,
          references(:companies, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:employees, [:company_id])
  end
end
