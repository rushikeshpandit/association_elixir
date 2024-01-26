defmodule AssociationElixirWeb.Api.EmployeeController do
  use AssociationElixirWeb, :controller

  alias AssociationElixir.Employees
  alias AssociationElixir.Employees.Employee

  action_fallback AssociationElixirWeb.FallbackController

  def index(conn, _params) do
    employees = Employees.list_employees()
    render(conn, :index, employees: employees)
  end

  def create(conn, %{"employee" => employee_params}) do
    with {:ok, %Employee{} = employee} <- Employees.create_employee(employee_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/employees/#{employee}")
      |> render(:show, employee: employee)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Employees.get_employee!(id)
    render(conn, :show, employee: employee)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Employees.get_employee!(id)

    with {:ok, %Employee{} = employee} <- Employees.update_employee(employee, employee_params) do
      render(conn, :show, employee: employee)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Employees.get_employee!(id)

    with {:ok, %Employee{}} <- Employees.delete_employee(employee) do
      send_resp(conn, :no_content, "")
    end
  end

  def list_employees(conn, %{"id" => id}) do
    employees = Employees.list_employees_by(id)
    render(conn, :index, employees: employees)
  end
end
