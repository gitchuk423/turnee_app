module AttorneysHelper

  # Returns the Gravatar (http://gravatar.com/) for the given user.
  def gravatar_for(attorney)
    gravatar_id = Digest::MD5::hexdigest(attorney.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: attorney.name, class: "gravatar")
  end


end
