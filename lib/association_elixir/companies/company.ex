defmodule AssociationElixir.Companies.Company do
  alias AssociationElixir.Employees.Employee
  alias AssociationElixir.Deparments.Department
  alias AssociationElixir.Locations.Location
  use Ecto.Schema
  import Ecto.Changeset

  @type_values ~w/SERVICE PRODUCT/a
  @fields ~w/type/a
  @required_fields ~w/name description/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "companies" do
    field :name, :string
    field :description, :string
    field :type, Ecto.Enum, values: @type_values, default: :SERVICE

    has_many :departments, Department
    has_many :locations, Location
    has_many :employees, Employee

    timestamps(type: :utc_datetime)
  end

  def changeset(attrs) do
    changeset(%__MODULE__{}, attrs)
  end

  @doc false
  def changeset(company, attrs) do
    company
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_length(:name,
      min: 6,
      max: 100,
      message: "Company name should be minimum 6 characters"
    )
    |> unique_constraint(:name)
  end
end
