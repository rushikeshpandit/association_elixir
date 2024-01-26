defmodule AssociationElixirWeb.Api.EmployeeJSON do
  alias AssociationElixir.Employees.Employee

  @doc """
  Renders a list of employees.
  """
  def index(%{employees: employees}) do
    %{data: for(employee <- employees, do: data(employee))}
  end

  @doc """
  Renders a single employee.
  """
  def show(%{employee: employee}) do
    %{data: data(employee)}
  end

  defp data(%Employee{} = employee) do
    %{
      id: employee.id,
      first_name: employee.first_name,
      last_name: employee.last_name
    }
  end
end
