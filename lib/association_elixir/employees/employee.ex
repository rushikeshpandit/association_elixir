defmodule AssociationElixir.Employees.Employee do
  alias AssociationElixir.Companies.Company
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "employees" do
    field :first_name, :string
    field :last_name, :string
    belongs_to :company, Company

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:first_name, :last_name, :company_id])
    |> validate_required([:first_name, :last_name, :company_id])
    |> validate_length(:first_name,
      min: 4,
      max: 100,
      message: "Employee First Name should be minimum 4 characters"
    )
    |> validate_length(:last_name,
      min: 4,
      max: 100,
      message: "Employee Last Name should be minimum 4 characters"
    )
  end
end
