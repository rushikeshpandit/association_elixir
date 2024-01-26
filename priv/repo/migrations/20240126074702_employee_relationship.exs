defmodule AssociationElixir.Repo.Migrations.EmployeeRelationship do
  use Ecto.Migration

  def change do
    alter table(:employees) do
      add :department_id,
          references(:departments,
            on_delete: :delete_all,
            on_update: :update_all,
            type: :binary_id
          )

      add :location_id,
          references(:locations,
            on_delete: :delete_all,
            on_update: :update_all,
            type: :binary_id
          )
    end

    create index(:employees, [:department_id])
    create index(:employees, [:location_id])
  end
end
