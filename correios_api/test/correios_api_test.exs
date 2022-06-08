defmodule CorreiosApiTest do
  use ExUnit.Case
  doctest CorreiosApi

  describe "fetch_zipcode/1" do
    test "with a valid zipcode" do
      response = CorreiosApi.fetch_zipcode("35162333")

      expected_respose =
        {:ok,
         %{
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
         }}

      assert response == expected_respose
    end

    test "with an invalid zipcode" do
      response = CorreiosApi.fetch_zipcode("35162333a")
      expected_respose = {:error, "Bad Request"}

      assert response == expected_respose
    end
  end
end
