defmodule ShelterdbWeb.PowResetPassword.MailerView do
  use ShelterdbWeb, :mailer_view

  def subject(:reset_password, _assigns), do: "Reset password link"
end
