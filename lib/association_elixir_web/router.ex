defmodule AssociationElixirWeb.Router do
  use AssociationElixirWeb, :router
  alias AssociationElixirWeb.Middleware.EnsureAuthenticated
  alias AssociationElixirWeb.Middleware.IsAdmin

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :is_admin do
    plug IsAdmin
  end

  pipeline :authenticated do
    plug EnsureAuthenticated
  end

  scope "/api", AssociationElixirWeb.Api, as: :api do
    pipe_through :api

    scope "/admin", Admin, as: :admin do
      pipe_through :is_admin
    end

    scope "/" do
      pipe_through :authenticated
      post "/session/me", SessionController, :me
      get "/users/:id", UserController, :show
    end

    post "/users", UserController, :create
    post "/session", SessionController, :create
    post "/session/forgot_password", SessionController, :forgot_password
    post "/session/reset_password", SessionController, :reset_password
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:association_elixir, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: AssociationElixirWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
