defmodule ShelterdbWeb.Pow.Mailer do
  use Pow.Phoenix.Mailer
  require Logger
  # use Bamboo.Mailer, otp_app: :shelterdb

  # import Bamboo.Email

  #@impl true
  #def cast(%{user: user, subject: subject, text: text, html: html}) do
  #  new_email(
  #    to: user.email,
  #    from: "myapp@example.com",
  #    subject: subject,
  #    html_body: html,
  #    text_body: text
  #  )
  #end

  def cast(%{user: user, subject: subject, text: text, html: html, assigns: _assigns}) do
    # Build email struct to be used in `process/1`

    %{to: user.email, subject: subject, text: text, html: html}
  end

  #@impl true
  #def process(email) do
  #  # An asynchronous process should be used here to prevent enumeration
  #  # attacks. Synchronous e-mail delivery can reveal whether a user already
  #  # exists in the system or not.

  #  deliver_later(email)
  #end

  def process(email) do
    # Send email

    Logger.debug("E-mail sent: #{inspect email}")
  end
end
