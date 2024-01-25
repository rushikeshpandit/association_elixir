defmodule AssociationElixir.Repo.Migrations.CreateLocations do
  use Ecto.Migration

  def change do
    create table(:locations, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :address, :string
      add :city, :string
      add :state, :string
      add :country, :string
      add :pincode, :integer

      add :company_id,
          references(:companies, on_delete: :delete_all, on_update: :update_all, type: :binary_id)

      timestamps(type: :utc_datetime)
    end

    create index(:locations, [:company_id])
  end
end
