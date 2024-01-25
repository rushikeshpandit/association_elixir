defmodule AssociationElixirWeb.Api.LocationController do
  use AssociationElixirWeb, :controller

  alias AssociationElixir.Locations

  action_fallback AssociationElixirWeb.FallbackController

  def index(conn, _params) do
    locations = Locations.list_locations()
    render(conn, :index, locations: locations)
  end

  def show(conn, %{"id" => id}) do
    location = Locations.get_location!(id)
    render(conn, :show, location: location)
  end

  def list_locations(conn, %{"id" => id}) do
    locations = Locations.list_locations_by(id)
    render(conn, :index, locations: locations)
  end
end
