defmodule AssociationElixirWeb.Api.DepartmentController do
  use AssociationElixirWeb, :controller

  alias AssociationElixir.Deparments

  action_fallback AssociationElixirWeb.FallbackController

  def index(conn, _params) do
    departments = Deparments.list_departments()
    render(conn, :index, departments: departments)
  end

  def show(conn, %{"id" => id}) do
    department = Deparments.get_department!(id)
    render(conn, :show, department: department)
  end

  def list_departments(conn, %{"id" => id}) do
    departments = Deparments.list_departments_by(id)
    render(conn, :index, departments: departments)
  end
end
