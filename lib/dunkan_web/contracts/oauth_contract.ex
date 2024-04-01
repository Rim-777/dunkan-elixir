defmodule DunkanWeb.Contracts.OauthContract do
  @schema %{
            "type" => "object",
            "additionalProperties" => false,
            "required" => ["user"],
            "properties" => %{
              "user" => %{
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
                    "required" => ["displayed_name", "photo_url"],
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
          |> ExJsonSchema.Schema.resolve()

  def validate(%{} = map) do
    ExJsonSchema.Validator.validate(@schema, map)
  end
end
