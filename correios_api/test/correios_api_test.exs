defmodule CorreiosApiTest do
  use ExUnit.Case

  import Mox

  doctest CorreiosApi

  setup :verify_on_exit!

  describe "fetch_zipcode/1" do
    test "testing mox" do
      expect(HTTPPoisonMock, :get, fn _ -> {:ok, "What a guy!"} end)

      assert Application.get_env(:correios_api, :http_client).get("a") == {:ok, "What a guy!"}
    end

    test "with a valid zipcode" do
      expected_body = %{
        "bairro" => "Esperança",
        "cep" => "35162-333",
        "complemento" => "",
        "ddd" => "31",
        "gia" => "",
        "ibge" => "3131307",
        "localidade" => "Ipatinga",
        "logradouro" => "Rua Magnólia",
        "siafi" => "4625",
        "uf" => "MG"
      }

      expect(HTTPPoisonMock, :get, fn url ->
        assert url == "viacep.com.br/ws/35162333/json/"

        {:ok, %HTTPoison.Response{body: Jason.encode!(expected_body), status_code: 200}}
      end)

      response = CorreiosApi.fetch_zipcode("35162333")

      expected_respose = {:ok, expected_body}

      assert response == expected_respose
    end

    test "with an invalid zipcode" do
      expect(HTTPPoisonMock, :get, fn url ->
        assert url == "viacep.com.br/ws/35162333a/json/"

        {:ok, %HTTPoison.Response{status_code: 400}}
      end)

      response = CorreiosApi.fetch_zipcode("35162333a")

      expected_respose = {:error, "Bad Request"}

      assert response == expected_respose
    end
  end
end
