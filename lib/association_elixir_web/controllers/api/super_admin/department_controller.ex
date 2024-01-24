defmodule AssociationElixirWeb.Api.SuperAdmin.DepartmentController do
  use AssociationElixirWeb, :controller

  alias AssociationElixir.Deparments
  alias AssociationElixir.Deparments.Department

  action_fallback AssociationElixirWeb.FallbackController

  # def index(conn, _params) do
  #   departments = Deparments.list_departments()
  #   render(conn, :index, departments: departments)
  # end

  def create(conn, %{"department" => department_params}) do
    with {:ok, %Department{} = department} <- Deparments.create_department(department_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/departments/#{department}")
      |> render(:show, department: department)
    end
  end

  # def show(conn, %{"id" => id}) do
  #   department = Deparments.get_department!(id)
  #   render(conn, :show, department: department)
  # end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = Deparments.get_department!(id)

    with {:ok, %Department{} = department} <-
           Deparments.update_department(department, department_params) do
      render(conn, :show, department: department)
    end
  end

  def delete(conn, %{"id" => id}) do
    department = Deparments.get_department!(id)

    with {:ok, %Department{}} <- Deparments.delete_department(department) do
      send_resp(conn, :no_content, "")
    end
  end
end
