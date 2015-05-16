module ApplicationHelper

  def render_auth_token
    "<input
      type=\"hidden\"
      name=\"authenticity_token\"
      value=\"#{form_authenticity_token}\">".html_safe
  end

  def display_messages
    str = ""

    if flash[:success]
      str << flash[:success]
    end

    if flash.now[:errors]
      flash.now[:errors].each do |error|
        str << "<li>#{error}</li>"
      end
    end

    "<ul>#{str}</ul>".html_safe
  end

end
