defmodule CvmeWeb.Token do
  alias Phoenix.Token
  alias CvmeWeb.Endpoint

  @sign_salt "cvme_api"

  def sign(user) do
    Token.sign(Endpoint, @sign_salt, %{user_id: user.id})
  end

  def verify(token), do: Token.verify(Endpoint, @sign_salt, token)
end
