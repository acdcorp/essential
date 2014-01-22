class ClaimsController < ApplicationController
  def index
  end

  def new
    @claim_form = ClaimForm.new current_user
  end

  def form
    # No type, you should sort that out!
    raise 'Please send a type' unless params[:type]
    # Stop people fishing for forms they don't have access too
    unless %w(primary_client_contact).include? params[:type]
      raise "There is no type #{params[:type]}"
    end

    case params[:type]
    when 'primary_client_contact'
      form = 'primary_client_contact'
      @primary_client_contacts = Common::Company.find(params[:value]).users
    end

    @claim_form = ClaimForm.new current_user

    respond_to do |format|
      format.html do
        doc = Nokogiri::HTML(render_to_string partial: "claims/forms/#{form}")
        render text: doc.at('form').inner_html
      end
    end
  end
end
