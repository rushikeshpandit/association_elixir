defmodule AssociationElixir.Repo.Migrations.CreateDepartments do
  use Ecto.Migration

  def change do
    create table(:departments, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :budget, :integer

      add :company_id,
          references(:companies, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:departments, [:company_id])
  end
end
