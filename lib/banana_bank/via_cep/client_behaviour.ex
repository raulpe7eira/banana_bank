defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback base_url() :: binary()
  @callback call(map()) :: {:ok, map()} | {:error, atom()}
end
