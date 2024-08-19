defmodule CvmeWeb.AuthToken do
  alias CvmeWeb.Endpoint
  alias Phoenix.Token

  @sign_salt "cvme-xisdizko"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{email: user.email})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
