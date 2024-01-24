defmodule AssociationElixirWeb.Api.SuperAdmin.DepartmentJSON do
  alias AssociationElixir.Deparments.Department

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
      budget: department.budget
    }
  end
end
