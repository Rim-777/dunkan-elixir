defmodule DunkanWeb.ErrorJSON do
  # If you want to customize a particular status code,
  # you may add your own clauses, such as:
  #
  # def render("500.json", _assigns) do
  #   %{errors: %{detail: "Internal Server Error"}}
  # end

  def render("400.json", assigns) do
    assigns.json_schema_error
    |> detail()
  end

  # By default, Phoenix returns the status message from
  # the template name. For example, "404.json" becomes
  # "Not Found".
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
    |> detail()
  end

  defp detail(errors) do
    %{errors: %{detail: errors}}
  end
end
