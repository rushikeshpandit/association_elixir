defmodule AssociationElixir.Deparments.Department do
  alias AssociationElixir.Employees.Employee
  alias AssociationElixir.Companies.Company
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "departments" do
    field :name, :string
    field :budget, :integer

    belongs_to :company, Company
    has_one :employee, Employee

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(department, attrs) do
    department
    |> cast(attrs, [:name, :budget, :company_id])
    |> validate_required([:name, :budget, :company_id])
    |> validate_number(:budget, greater_than: 10_000)
    |> validate_length(:name,
      min: 6,
      max: 100,
      message: "Department name should be minimum 6 characters"
    )
  end
end
