defmodule ShelterdbWeb.Router do
  use ShelterdbWeb, :router
  use Pow.Phoenix.Router
  use Pow.Extension.Phoenix.Router,
    extensions: [PowResetPassword, PowInvitation]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {ShelterdbWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :protected do
    plug Pow.Plug.RequireAuthenticated,
      error_handler: Pow.Phoenix.PlugErrorHandler
  end

  pipeline :admin do
    plug ShelterdbWeb.EnsureRolePlug, :admin
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PowInvitation.Phoenix, as: "pow_invitation" do
    pipe_through [:browser, :protected, :admin]
    resources "/invitations", InvitationController, only: [:new, :create, :show]
  end

  scope "/", Pow.Phoenix, as: "pow" do
    pipe_through [:browser, :protected]
    resources "/registration", RegistrationController, singleton: true, only: [:edit, :update, :delete]
  end

  scope "/" do
    pipe_through :browser

    pow_session_routes()
    pow_extension_routes()
  end

  scope "/", ShelterdbWeb do
    pipe_through :browser

    live "/", PageLive, :index
  end

  scope "/admin", ShelterdbWeb do
    pipe_through [:browser, :admin]

    #admin routes go here, idk how the fuck this works
  end

  # Other scopes may use custom stacks.
  # scope "/api", ShelterdbWeb do
  #   pipe_through :api
  # end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ShelterdbWeb.Telemetry
    end
  end
end
