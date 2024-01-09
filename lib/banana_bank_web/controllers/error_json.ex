defmodule BananaBankWeb.ErrorJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    %{errors: %{detail: Phoenix.Controller.status_message_from_template(template)}}
  end

  def error(%{changeset: changeset}) do
    %{errors: Ecto.Changeset.traverse_errors(changeset, &translate_errors/1)}
  end

  def error(%{generic: generic}) do
    %{errors: %{message: "Generic error", data: generic}}
  end

  def error(%{status: :invalid_account}) do
    %{errors: %{account_id: ["invalid value"]}}
  end

  def error(%{status: :invalid_amount}) do
    %{errors: %{amount: ["invalid value"]}}
  end

  def error(%{status: :invalid_cep}) do
    %{errors: %{cep: ["invalid value"]}}
  end

  def error(%{status: :invalid_transaction}) do
    %{errors: %{params: ["invalid values"]}}
  end

  def error(%{status: :invalid_user}) do
    %{errors: %{user_id: ["invalid value"]}}
  end

  def error(%{status: :not_found}) do
    %{errors: %{message: "Resource not found", data: :not_found}}
  end

  def error(%{status: :unauthorized}) do
    %{errors: %{message: "Unauthorized access", data: :unauthorized}}
  end

  defp translate_errors({msg, opts}) do
    Regex.replace(~r"%{(\w+)}", msg, fn _, key ->
      opts |> Keyword.get(String.to_existing_atom(key), key) |> to_string()
    end)
  end
end
