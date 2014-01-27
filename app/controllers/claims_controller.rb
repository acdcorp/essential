class ClaimsController < ApplicationController
  has_widgets do |root|
    root << widget('claim/form', :claim_form)
  end

  def index
  end

  def new
  end
end
