defmodule DunkanWeb.OauthControllerTest do
  use DunkanWeb.ConnCase
  import Dunkan.UsersFixtures
  alias Dunkan.User
  alias Dunkan.Profile

  @oauth_attrs %{
    oauth_user: %{
      email: "some@email.com",
      password: "12345678",
      profile: %{
        displayed_name: "Michael Jordan"
      },
      oauth_provider: %{name: "google", uid: "1234567"}
    }
  }

  @invalid_attrs %{
    oauth_user: %{
      email: "some@email",
      password: "pass",
      profile: %{
        displayed_name: nil
      },
      oauth_provider: %{name: "googl", uid: "1234567"}
    }
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "oauth user" do
    defp request(param, conn) do
      post(conn, ~p"/api/auth/create", param)
    end

    test "POST /api/auth/create new user with nominal params", %{conn: conn} do
      response = request(@oauth_attrs, conn)

      assert %{
               "attributes" => %{"email" => "some@email.com", "phone_number" => nil},
               "id" => _id,
               "relationships" => %{
                 "profile" => %{
                   "data" => %{
                     "attributes" => %{
                       "first_name" => nil,
                       "last_name" => nil,
                       "middle_name" => nil,
                       "displayed_name" => "Michael Jordan",
                       "gender" => nil,
                       "photo_url" => nil,
                       "profile_type" => nil,
                       "date_of_birth" => nil
                     },
                     "id" => _profile_id,
                     "type" => "profile"
                   }
                 }
               },
               "type" => "user"
             } = json_response(response, 200)["data"]
    end

    test "POST /api/auth/create existing user with nominal params", %{conn: conn} do
      %User{id: user_id, profile: %Profile{id: profile_id}} =
        user_fixture(%{
          email: @oauth_attrs.oauth_user.email,
          password: @oauth_attrs.oauth_user.password,
          oauth_provider: @oauth_attrs.oauth_user.oauth_provider
        })

      response = request(@oauth_attrs, conn)

      assert %{
               "id" => ^user_id,
               "type" => "user",
               "attributes" => %{
                 "email" => "some@email.com",
                 "phone_number" => nil
               },
               "relationships" => %{
                 "profile" => %{
                   "data" => %{
                     "id" => ^profile_id,
                     "type" => "profile",
                     "attributes" => %{
                       "displayed_name" => "Michael Jordan",
                       "first_name" => nil,
                       "last_name" => nil,
                       "photo_url" => nil,
                       "profile_type" => "player",
                       "date_of_birth" => nil
                     }
                   }
                 }
               }
             } = json_response(response, 200)["data"]
    end

    test "POST /api/auth/create existing user invalid password value", %{conn: conn} do
      %User{} =
        user_fixture(%{
          email: @oauth_attrs.oauth_user.email,
          password: "some invalid password"
        })

      response = request(@oauth_attrs, conn)

      assert %{"detail" => "Invalid Login or Password"} = json_response(response, 401)["errors"]
    end

    test "POST /api/auth/create user with invalid params", %{conn: conn} do
      response = request(@invalid_attrs, conn)

      assert %{
               "detail" => [
                 %{"#/oauth_user/oauth_provider/name" => "Value is not allowed in enum."},
                 %{
                   "#/oauth_user/profile/displayed_name" =>
                     "Type mismatch. Expected String but got Null."
                 }
               ]
             } = json_response(response, 400)["errors"]
    end

    test "POST /api/auth/create 422 invalid password length", %{conn: conn} do
      response =
        put_in(@oauth_attrs[:oauth_user].password, "1234567") |> request(conn)

      assert %{"password" => ["Min length 8 symbols"]} = json_response(response, 422)["errors"]
    end

    test "POST /api/auth/create 422 invalid email format", %{conn: conn} do
      response =
        put_in(@oauth_attrs[:oauth_user].email, "invalid@format") |> request(conn)

      assert %{"email" => ["Invalid format"]} = json_response(response, 422)["errors"]
    end
  end
end
