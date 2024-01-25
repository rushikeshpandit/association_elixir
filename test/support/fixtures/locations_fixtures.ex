defmodule AssociationElixir.LocationsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssociationElixir.Locations` context.
  """

  def location_attrs(attrs \\ %{}) do
    valid_attrs = %{
      address: "Whitefield",
      city: "Bangalore",
      country: "India",
      pincode: 560_066,
      state: "Karnataka"
    }

    Enum.into(attrs, valid_attrs)
  end

  @doc """
  Generate a location.
  """
  def location_fixture(attrs \\ %{}) do
    {:ok, location} =
      attrs
      |> Enum.into(%{
        address: "Whitefield",
        city: "Bangalore",
        country: "India",
        pincode: 560_066,
        state: "Karnataka"
      })
      |> AssociationElixir.Locations.create_location()

    location
  end
end
