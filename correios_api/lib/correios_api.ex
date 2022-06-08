defmodule CorreiosApi do
  # NOTE: This one is to setup the API
  def setup do
    Application.put_env(:correios_api, :http_client, HTTPoison)
  end

  def fetch_zipcode(zipcode) do
    {:ok, %HTTPoison.Response{} = response} =
      http_client().get("viacep.com.br/ws/#{zipcode}/json/")

    case response do
      %{status_code: 200, body: body} -> {:ok, Jason.decode!(body)}
      _ -> {:error, "Bad Request"}
    end
  end

  defp http_client do
    Application.get_env(:correios_api, :http_client)
  end
end
