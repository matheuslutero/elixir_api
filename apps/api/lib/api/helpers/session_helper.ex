defmodule Restfid.API.SessionHelper do
  @moduledoc """
  helper to provision a new user session
  """

  alias Restfid.API.Guardian
  alias Restfid.Database.User
  alias Restfid.Database.UserReader
  alias Restfid.Database.UserSession
  alias Restfid.Database.UserSessionWriter

  import Comeonin.Bcrypt, only: [checkpw: 2, dummy_checkpw: 0]

  def get_new_session(params) do
    case validate_params(params) do
      true ->
        case build_session_params(params) do
          {:ok, session_params} ->
            insert_new_session(session_params)

          {:error, message} ->
            {:error, message}
        end

      false ->
        {:error, "invalid_parameters"}
    end
  end

  def validate_params(params) do
    !(Blankable.blank?(params["email"]) && Blankable.blank?(params["phone"])) &&
      !Blankable.blank?(params["password"]) &&
      !Blankable.blank?(params["app_version"])
  end

  def build_session_params(params) do
    case get_user(params) do
      {:ok, user} ->
        {:ok, token, claims} = Guardian.encode_and_sign(user)
        {:ok, expiration_date} = DateTime.from_unix(claims["exp"])

        session_params = %UserSession{
          user_id: user.id,
          token: token,
          app_version: params["app_version"],
          expiration_date: expiration_date
        }

        {:ok, session_params}

      {:error, message} ->
        {:error, message}
    end
  end

  defp insert_new_session(session_params) do
    case UserSessionWriter.insert(session_params) do
      {:ok, user_session} ->
        {:ok, user_session}

      {:error, _} ->
        {:error, "internal_error"}
    end
  end

  defp get_user(params) do
    cond do
      !Blankable.blank?(params["email"]) ->
        get_user_by_email(params["email"], params["password"])

      !Blankable.blank?(params["phone"]) ->
        get_user_by_phone(params["phone"], params["password"])
    end
  end

  defp get_user_by_email(email, password) do
    case UserReader.one(User.by_email(email)) do
      nil ->
        dummy_checkpw()
        {:error, "unauthorized"}

      user ->
        verify_password(password, user)
    end
  end

  defp get_user_by_phone(phone, password) do
    case UserReader.one(User.by_phone(phone)) do
      nil ->
        dummy_checkpw()
        {:error, "unauthorized"}

      user ->
        verify_password(password, user)
    end
  end

  defp verify_password(password, %User{} = user) when is_binary(password) do
    if checkpw(password, user.password_hash) do
      {:ok, user}
    else
      {:error, "unauthorized"}
    end
  end
end
