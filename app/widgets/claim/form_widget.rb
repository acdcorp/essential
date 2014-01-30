class Claim::FormWidget < Apotomo::Widget
  responds_to_event :selected_company
  responds_to_event :selected_carrier
  responds_to_event :selected_carrier_office
  responds_to_event :selected_carrier_adjuster
  responds_to_event :add_carrier
  responds_to_event :add_carrier_office
  responds_to_event :add_carrier_adjuster
  responds_to_event :create_carrier
  responds_to_event :create_carrier_office
  responds_to_event :create_carrier_adjuster
  responds_to_event :created_carrier
  responds_to_event :created_carrier_office
  responds_to_event :created_carrier_adjuster
  responds_to_event :submit_claim

  def display
    render
  end

  def submit_claim data
    if form.validate data[:claim]
      form.save_as current_user
      # trigger carrier created
      trigger :created_claim, model: form.model
      replace state: :display
    else
      ap form.errors.messages
      replace state: :display
    end
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

  ### Carrier Adjuster ###

  def selected_carrier_adjuster data
    form.carrier_office_adjuster_id = data[:value]

    replace '#claim-selected-carrier-adjuster', text: render_view(:selected_carrier_adjuster)
  end

  def add_carrier_adjuster data
    @carrier_adjuster_form = CarrierAdjusterForm.new CarrierAdjuster.new({
      carrier_office_id: data[:carrier_office_id]
    })

    modal title: 'Add Carrier Adjuster', buttons: {
      main: {
        label: 'Add',
        className: 'btn-primary'
      }
    }
  end

  def create_carrier_adjuster data
    @carrier_adjuster_form = CarrierAdjusterForm.new CarrierAdjuster.new

    if @carrier_adjuster_form.validate data[:carrier_adjuster]
      @carrier_adjuster_form.save_as current_user
      # update the form carrier id
      form.carrier_office_adjuster_id = @carrier_adjuster_form.model.id
      form.carrier_office_id          = @carrier_adjuster_form.model.carrier_office_id
      # trigger carrier created
      trigger :created_carrier_adjuster, model: @carrier_adjuster_form.model
      # close modals on the page
      close_modals
    else
      replace '#claim-add-carrier-adjuster', view: :add_carrier_adjuster
    end
  end

  def created_carrier_adjuster data
    replace '#claim-carrier-adjuster', text: render_view(:carrier_adjuster)
  end

  ### Misc ###

  def form
    @form ||= options[:form] ||= ->(params) do
      ap params

      if params['controller'] == 'claims' and (id = params['id']) and id.is_i?
        claim = Claim.find id
      elsif params['claim'] and (id = params['claim']['id'])
        claim = Claim.find id
      elsif id = params['claim_id']
        claim = Claim.find id
      elsif id = options[:claim_id]
        claim = Claim.find id
      else
        claim = Claim.new
        claim.build_owner
        claim.build_company
      end

      ClaimForm.new claim.restrict! current_user
    end.call(params)
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
