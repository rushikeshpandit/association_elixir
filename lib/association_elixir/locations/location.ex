defmodule AssociationElixir.Locations.Location do
  alias AssociationElixir.Employees.Employee
  alias AssociationElixir.Companies.Company
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "locations" do
    field :state, :string
    field :address, :string
    field :city, :string
    field :country, :string
    field :pincode, :integer

    belongs_to :company, Company
    has_one :employee, Employee

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(location, attrs) do
    location
    |> cast(attrs, [:address, :city, :state, :country, :pincode, :company_id])
    |> validate_required([:address, :city, :state, :country, :pincode, :company_id])
    |> validate_inclusion(:pincode, 99_999..1_000_000,
      message: "Location pin code should be 6 digit"
    )
    |> validate_length(:state,
      min: 4,
      max: 100,
      message: "Location state should be minimum 4 characters"
    )
    |> validate_length(:address,
      min: 4,
      max: 100,
      message: "Location address should be minimum 4 characters"
    )
    |> validate_length(:city,
      min: 4,
      max: 100,
      message: "Location city should be minimum 4 characters"
    )
    |> validate_length(:country,
      min: 4,
      max: 100,
      message: "Location country should be minimum 4 characters"
    )
  end
end
