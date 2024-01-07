defmodule BananaBank.ViaCep.ClientImpl do
  @behaviour BananaBank.ViaCep.ClientBehaviour
  use Tesla

  alias BananaBank.ViaCep.ClientBehaviour

  plug Tesla.Middleware.BaseUrl, via_cep_client_impl().base_url()
  plug Tesla.Middleware.JSON

  @impl ClientBehaviour
  def base_url(), do: "https://viacep.com.br/ws"

  @impl ClientBehaviour
  def call(params)

  def call(%{"cep" => cep}) do
    "/#{cep}/json"
    |> get()
    |> handle_response()
  end

  def call(_), do: {:error, :invalid_cep}

  defp handle_response({:error, _}) do
    {:error, :internal_server_error}
  end

  defp handle_response({:ok, %Tesla.Env{status: 400}}) do
    {:error, :invalid_cep}
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: %{"erro" => true}}}) do
    {:error, :not_found}
  end

  defp handle_response({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp via_cep_client_impl() do
    Application.get_env(:banana_bank, :via_cep_client, __MODULE__)
  end
end
