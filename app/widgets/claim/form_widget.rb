class Claim::FormWidget < Apotomo::Widget
  responds_to_event :selected_company
  responds_to_event :selected_carrier
  responds_to_event :add_carrier

  def display
    render
  end

  def selected_company data
    form.model.company_id = data[:value]

    update '#claim-company', text: render_view
  end

  def selected_carrier data
    form.model.carrier_id = data[:value]

    update '#claim-carrier', text: render_view
  end

  def add_carrier data
    modal title: 'Add Carrier', buttons: {
      main: {
        label: 'Add',
        className: 'btn-primary',
        callback: -> { return false; }
      }
    }
  end

  def form
    @form ||= options[:form] ||= -> do
      if id = options[:claim_id]
        claim = Claim.find id
      else
        claim = Claim.new
        claim.build_owner
        claim.build_carrier
      end

      ClaimForm.new claim.restrict! current_user
    end.call
  end
  helper_method :form

  private

  def render_view
    sf = view_context.simple_form_for form, html: { class: 'form-horizontal'} do |f|
      render locals: { form: form, f: f }
    end

    doc  = Nokogiri::HTML sf
    doc.css('form').inner_html
  end
end
