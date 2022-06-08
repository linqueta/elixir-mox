ExUnit.start()

Mox.defmock(HTTPPoisonMock, for: HTTPoison.Base)
Application.put_env(:correios_api, :http_client, HTTPPoisonMock)
