class Claim::FormWidget < Apotomo::Widget
  responds_to_event :company_selected

  def display
    render
  end

  def company_selected data
    form.model.company_id = data[:value]

    update '#claim-company', text: render_view
  end

  def form
    @form ||= ClaimForm.new current_user
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
