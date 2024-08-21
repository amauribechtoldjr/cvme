defmodule CvmeWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :cvme,
    module: CvmeWeb.Auth.Guardian,
    error_handler: CvmeWeb.Auth.GuardianErrorHandler

  plug Guardian.Plug.VerifySession
  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
