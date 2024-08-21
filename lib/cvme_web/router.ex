defmodule CvmeWeb.Router do
  use CvmeWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug CvmeWeb.Auth.Pipeline
  end

  scope "/api", CvmeWeb do
    pipe_through :api

    get "/", WelcomeController, :index

    # Users
    resources "/users", UsersController, only: [:create]
    post "/users/sign_in", UsersController, :sign_in
  end

  scope "/api", CvmeWeb do
    pipe_through [:api, :auth]

    resources "/users", UsersController, only: [:update, :delete, :show]
    get "/users/:id/experiences", UsersController, :experiences

    # Experiences
    resources "/experiences", ExperiencesController, only: [:create, :update, :delete]
  end

  # Enable LiveDashboard in development
  if Application.compile_env(:cvme, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through [:fetch_session, :protect_from_forgery]

      live_dashboard "/dashboard", metrics: CvmeWeb.Telemetry
    end
  end
end
