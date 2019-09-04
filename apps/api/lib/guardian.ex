defmodule Restfid.API.Guardian do
  use Guardian, otp_app: :api

  alias Restfid.Database.UserReader

  def subject_for_token(user, _claims) do
    sub = to_string(user.id)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    resource = UserReader.get!(id)
    {:ok,  resource}
  end
end
