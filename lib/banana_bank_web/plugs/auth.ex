defmodule BananaBankWeb.Plugs.Auth do
  import Plug.Conn

  alias BananaBankWeb.Token
  alias Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{user_id: user_id}} <- Token.verify(token) do
      assign(conn, :user_id, user_id)
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> Controller.put_view(BananaBankWeb.ErrorJSON)
        |> Controller.render(:error, status: :unauthorized)
        |> halt()
    end
  end
end
