defmodule CvmeWeb.Token do
  alias CvmeWeb.Endpoint
  alias Phoenix.Token
  alias Users.User

  @sign_salt "cvme-xisdizko"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{email: user.email})
  end

  defp verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
