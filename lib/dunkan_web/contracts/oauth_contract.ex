defmodule DunkanWeb.Contracts.OauthContract do
  alias ExJsonSchema.Validator
  alias ExJsonSchema.Schema

  @moduledoc """
   JSON schema validation contract
  """

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
                    "type" => "string"
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
                      },
                      "gender" => %{
                        "type" => "string",
                        "enum" => ["male", "female", "other"]
                      },
                      "profile_type" => %{
                        "type" => "string",
                        "enum" => ["player", "fun", "parent", "club", "trainer"]
                      },
                      "first_name" => %{
                        "type" => "string"
                      },
                      "last_name" => %{
                        "type" => "string"
                      },
                      "middle_name" => %{
                        "type" => "string"
                      },
                      "date_of_birth" => %{
                        "type" => "string"
                      }
                    }
                  }
                }
              }
            }
          }
          |> Schema.resolve()

  @doc """
   Accepts a map with combined user params, validates against given schema
   Returns valid params without root section  
   or indicates about invalid attributes
  """

  def validate(%{} = map) do
    with :ok <- Validator.validate(@schema, map) do
      {:ok, map["oauth_user"]}
    else
      {:error, errors} ->
        {:json_schema_error, Enum.map(errors, fn {k, v} -> %{v => k} end)}
    end
  end
end
