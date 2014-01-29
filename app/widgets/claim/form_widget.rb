class Claim::FormWidget < Apotomo::Widget
  responds_to_event :selected_company
  responds_to_event :selected_carrier
  responds_to_event :selected_carrier_office
  responds_to_event :add_carrier
  responds_to_event :add_carrier_office
  responds_to_event :create_carrier
  responds_to_event :create_carrier_office
  responds_to_event :created_carrier
  responds_to_event :created_carrier_office

  def display
    render
  end

  ### Comapany ###

  def selected_company data
    form.company_id = data[:value]

    replace '#claim-selected-company', text: render_view(:selected_company)
  end

  ### Carrier ###

  def selected_carrier data
    form.carrier_id = data[:value]

    replace '#claim-selected-carrier', text: render_view(:selected_carrier)
  end

  def add_carrier data
    @carrier_form = CarrierForm.new Carrier.new

    modal title: 'Add Carrier', buttons: {
      main: {
        label: 'Add',
        className: 'btn-primary'
      }
    }
  end

  def create_carrier data
    @carrier_form = CarrierForm.new Carrier.new

    if @carrier_form.validate data[:carrier]
      @carrier_form.save_as current_user
      # update the form carrier id
      form.carrier_id = @carrier_form.model.id
      # trigger carrier created
      trigger :created_carrier, model: @carrier_form.model
      # close modals on the page
      close_modals
    else
      replace '#claim-add-carrier', view: :add_carrier
    end
  end

  def created_carrier data
    replace '#claim-carrier', text: render_view(:carrier)
  end

  ### Carrier Office ###

  def selected_carrier_office data
    form.carrier_office_id = data[:value]

    replace '#claim-selected-carrier-office', text: render_view(:selected_carrier_office)
  end

  def add_carrier_office data
    @carrier_office_form = CarrierOfficeForm.new CarrierOffice.new({
      carrier_id: data[:carrier_id]
    })

    modal title: 'Add Carrier Office', buttons: {
      main: {
        label: 'Add',
        className: 'btn-primary'
      }
    }
  end

  def create_carrier_office data
    @carrier_office_form = CarrierOfficeForm.new CarrierOffice.new

    if @carrier_office_form.validate data[:carrier_office]
      @carrier_office_form.save_as current_user
      # update the form carrier id
      form.carrier_office_id = @carrier_office_form.model.id
      form.carrier_id        = @carrier_office_form.model.carrier_id
      # trigger carrier created
      trigger :created_carrier_office, model: @carrier_office_form.model
      # close modals on the page
      close_modals
    else
      replace '#claim-add-carrier-office', view: :add_carrier_office
    end
  end

  def created_carrier_office data
    replace '#claim-carrier-office', text: render_view(:carrier_office)
  end

  ### Misc ###

  def form
    @form ||= options[:form] ||= -> do
      if id = options[:claim_id]
        claim = Claim.find id
      else
        claim = Claim.new
        claim.build_owner
      end

      ClaimForm.new claim.restrict! current_user
    end.call
  end
  helper_method :form

  private

  def render_view view, local_form = false
    local_form ||= form

    html = render_to_string template: :simple_form, locals: {
      form: local_form, view: view
    }, layout: false

    doc  = Nokogiri::HTML html
    doc.css('form').inner_html
  end
end
