defmodule AssociationElixirWeb.Api.Admin.LocationJSON do
  alias AssociationElixir.Locations.Location

  @doc """
  Renders a list of locations.
  """
  def index(%{locations: locations}) do
    %{data: for(location <- locations, do: data(location))}
  end

  @doc """
  Renders a single location.
  """
  def show(%{location: location}) do
    %{data: data(location)}
  end

  defp data(%Location{} = location) do
    %{
      id: location.id,
      address: location.address,
      city: location.city,
      state: location.state,
      country: location.country,
      pincode: location.pincode
    }
  end
end
