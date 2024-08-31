defmodule CvmeWeb.AuthJSON do
  def sign_in(%{user: user}) do
    %{data: user}
  end

  def logout(%{user: user}) do
    %{data: user}
  end
end
