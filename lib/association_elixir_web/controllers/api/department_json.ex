defmodule AssociationElixirWeb.Api.DepartmentJSON do
  alias AssociationElixir.Deparments.Department
  alias AssociationElixirWeb.Api.CompaniesJSON

  @doc """
  Renders a list of departments.
  """
  def index(%{departments: departments}) do
    %{data: for(department <- departments, do: data(department))}
  end

  @doc """
  Renders a single department.
  """
  def show(%{department: department}) do
    %{data: data(department)}
  end

  defp data(%Department{} = department) do
    %{
      id: department.id,
      name: department.name,
      budget: department.budget,
      company: load_company(department.company, department.company_id)
    }
  end

  defp load_company(company, company_id) do
    if Ecto.assoc_loaded?(company) do
      CompaniesJSON.show(%{company: company})
    else
      %{id: company_id}
    end
  end
end
