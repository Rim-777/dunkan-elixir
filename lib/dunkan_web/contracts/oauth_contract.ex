defmodule DunkanWeb.Contracts.OauthContract do
  alias ExJsonSchema.Validator
  alias ExJsonSchema.Schema

  @schema %{
            "type" => "object",
            "additionalProperties" => false,
            "required" => ["oauth_user"],
            "properties" => %{
              "oauth_user" => %{
                "type" => "object",
                "additionalProperties" => false,
                "required" => ["email", "password", "oauth_provider", "profile"],
                "properties" => %{
                  "email" => %{
                    "type" => "string",
                    "format" => "email"
                  },
                  "password" => %{
                    "type" => "string"
                  },
                  "oauth_provider" => %{
                    "type" => "object",
                    "additionalProperties" => false,
                    "required" => ["name", "uid"],
                    "properties" => %{
                      "name" => %{
                        "type" => "string",
                        "enum" => ["google", "facebook", "apple"]
                      },
                      "uid" => %{
                        "type" => "string"
                      }
                    }
                  },
                  "profile" => %{
                    "type" => "object",
                    "additionalProperties" => false,
                    "required" => ["displayed_name"],
                    "properties" => %{
                      "displayed_name" => %{
                        "type" => "string"
                      },
                      "photo_url" => %{
                        "type" => "string"
                      }
                    }
                  }
                }
              }
            }
          }
          |> Schema.resolve()

  def validate(%{} = map) do
    with :ok <- Validator.validate(@schema, map) do
      {:ok, map["oauth_user"]}
    else
      {:error, errors} ->
        {:json_schema_error, errors}
    end
  end
end
