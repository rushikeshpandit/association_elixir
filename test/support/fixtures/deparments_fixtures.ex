defmodule AssociationElixir.DeparmentsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssociationElixir.Deparments` context.
  """

  def department_attrs(attrs \\ %{}) do
    valid_attrs = %{
      budget: 10_000,
      name: "Human Resource"
    }

    Enum.into(attrs, valid_attrs)
  end

  @doc """
  Generate a department.
  """
  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(%{
        budget: 10_000,
        name: "Human Resource"
      })
      |> AssociationElixir.Deparments.create_department()

    department
  end
end
