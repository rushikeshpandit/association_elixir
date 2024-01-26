defmodule AssociationElixir.EmployeesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssociationElixir.Employees` context.
  """
  def employee_attrs(attrs \\ %{}) do
    valid_attrs = %{
      first_name: "John",
      last_name: "Smith"
    }

    Enum.into(attrs, valid_attrs)
  end

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        first_name: "John",
        last_name: "Smith"
      })
      |> AssociationElixir.Employees.create_employee()

    employee
  end
end
