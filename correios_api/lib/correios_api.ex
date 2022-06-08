defmodule CorreiosApi do
  def fetch_zipcode(zipcode) do
    {:ok, %HTTPoison.Response{} = response} =
      http_client().get("viacep.com.br/ws/#{zipcode}/json/")

    case response do
      %{status_code: 200, body: body} -> {:ok, Jason.decode!(body)}
      _ -> {:error, "Bad Request"}
    end
  end

  defp http_client do
    HTTPoison
  end
end
