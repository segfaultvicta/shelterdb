defmodule ShelterdbWeb.PowInvitation.MailerView do
  use ShelterdbWeb, :mailer_view

  def subject(:invitation, _assigns), do: "You've been invited"
end
