defmodule CvmeWeb.AuthJSON do
  def ok(%{callback_url: callback_url}) do
    %{data: callback_url}
  end
end
