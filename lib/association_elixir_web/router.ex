defmodule AssociationElixirWeb.Router do
  use AssociationElixirWeb, :router
  alias AssociationElixirWeb.Middleware.EnsureAuthenticated
  alias AssociationElixirWeb.Middleware.IsAdmin
  alias AssociationElixirWeb.Middleware.IsSuperAdmin

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :is_admin do
    plug IsAdmin
  end

  pipeline :is_super_admin do
    plug IsSuperAdmin
  end

  pipeline :authenticated do
    plug EnsureAuthenticated
  end

  scope "/api", AssociationElixirWeb.Api, as: :api do
    pipe_through :api

    scope "/admin", Admin, as: :admin do
      pipe_through :is_admin
    end

    scope "/super_admin", SuperAdmin, as: :super_admin do
      pipe_through :is_super_admin

      # Only super admin can create, update and delete company
      post "/companies", CompanyController, :create
      put "/companies/:id", CompanyController, :update
      delete "/companies/:id", CompanyController, :delete

      # Only super admin can create, update and delete department
      post "/departments", DepartmentController, :create
      put "/departments/:id", DepartmentController, :update
      delete "/departments/:id", DepartmentController, :delete
    end

    scope "/" do
      pipe_through :authenticated
      post "/session/me", SessionController, :me
      get "/users/:id", UserController, :show

      # Authenticated user can only see the companies
      get "/companies", CompaniesController, :index
      get "/companies/:id", CompaniesController, :show

      # Authenticated user can only see the departments
      get "/departments", DepartmentController, :index
      get "/departments/:id", DepartmentController, :show
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
