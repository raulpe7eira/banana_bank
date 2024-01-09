defmodule BananaBank.ViaCep.ClientImplTest do
  use ExUnit.Case, async: true

  import Mox

  alias BananaBank.ViaCep.ClientBehaviourMock
  alias BananaBank.ViaCep.ClientImpl

  setup :verify_on_exit!

  setup do 
    {:ok, bypass: Bypass.open()}
  end

  describe "call/1" do
    test "when given a valid params, returns :ok", ctx do
      params = %{"cep" => "22730305"}

      expect(ClientBehaviourMock, :base_url, fn -> base_url(ctx.bypass.port) end)

      Bypass.expect(ctx.bypass, "GET", "/22730305/json", fn conn ->
        body = ~s'{
          "bairro": "Tanque",
          "cep": "22730-305",
          "complemento": "",
          "ddd": "21",
          "gia": "",
          "ibge": "3304557",
          "localidade": "Rio de Janeiro",
          "logradouro": "Rua Laura Teles",
          "siafi": "6001",
          "uf": "RJ"
        }'

        conn
        |> Plug.Conn.put_resp_content_type("application/json")
        |> Plug.Conn.resp(200, body)
      end)

      response = ClientImpl.call(params)

      expected_response =
        {:ok,
         %{
           "bairro" => "Tanque",
           "cep" => "22730-305",
           "complemento" => "",
           "ddd" => "21",
           "gia" => "",
           "ibge" => "3304557",
           "localidade" => "Rio de Janeiro",
           "logradouro" => "Rua Laura Teles",
           "siafi" => "6001",
           "uf" => "RJ"
         }}

      assert expected_response == response
    end
  end

  defp base_url(port), do: "http://localhost:#{port}/"
end
