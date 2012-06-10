def full_title(page_title)
  base_title = "Turnee"
  if page_title.empty?
    base_title
  else
    "#{base_title} | #{page_title}"
  end
end

def sign_in(attorney)
  visit signin_path
  fill_in "Email",    with: attorney.email
  fill_in "Password", with: attorney.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:remember_token] = attorney.remember_token
end

