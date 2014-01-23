steps_for :javascript do
  def jquery_fill_in(selector, options)
    page.execute_script %Q{
      $('body').focus;
      if((selector = $('##{selector}')).length || ($selector = $('label:contains(#{selector})').parent().find(':input')).length) {
          $selector.click().val('#{options[:with]}').focus().keydown().keyup();
      } else {
          throw 'Selector (#{selector}) not found';
      }
    }
  end

  def fill_in field, value, extras = []
    set_field :fill_in, field, (value[:with] || value), extras
  end

  def set_field action, field, value, extras = []
    # Set the extras array if need be
    extras = extras.blank? ? [] : extras.split(',').map { |e| e.strip }
    # Perform actions based on which one is set
    case action.to_s
    when 'select'
      select value, from: field
      should have_select field, selected: value
    when 'fill_in'
      # Store the original value incase we change it
      original_value = value
      # Remove anything that's not [a-z0-9] as the mask will add it back
      extras.each do |extra|
        case extra
        when 'mask'
          expect(find_field(field)['pt-mask']).to be_present,
            "No mask was found for: #{field}"
        when 'validate-cc'
          expect(find_field(field)['pt-validate-cc']).not_to be_nil,
            "No CC validation found for: #{field}"
        end
      end
      # Only use jquery fill if extras are set
      if extras.empty?
        # fill_in field, with: value
        find(:fillable_field, field, {}).set(value)
      else
        jquery_fill_in field, with: value
      end
      # Make sure the value is correct after all is said and done
      find_field(field).value.should eq original_value
      # If we have a datepicker make sure it shows
      find(:xpath, '//body').find('.datepicker.dropdown-menu').should be_visible if extras.include? 'datepicker'
    else
      throw "Missing action definition (#{action})"
    end
  end

  step "(I)(I'm)(I am) (on)(visit) (the) :name page" do |path_string|
    path = path_string.downcase.gsub(/\s/, '_').gsub(/^create_/, 'new_')
    path = send("#{path}_path")
    visit path
    expect(current_path).to eq path
  end

  step '(I) (should)(finally I should) see :name' do |content|
    expect(page).to have_content content
  end

  step '(I) (click) (press) (the) :name link' do |name|
    click_link name
  end

  step '(I) (click) (press) (the) :name button' do |name|
    click_button name
  end

  step 'I see the following (images) (logos) :name' do |images|
    images.gsub!(/\ and/, ',')
    images.split(',').each do |image|
      image_name = image.strip.gsub(/\s/, '_').downcase
      expect(page).to have_xpath "//img[contains(@alt, \"#{image_name}\")]"
    end
  end

  step 'I should :words :name with :name' do |action, field, value|
    set_field action.chomp.gsub(' ', '_'), field, value
  end

  step "(I'm) (l)(L)ogged in as (an) (a) :name" do |role_name|
    login role_name.downcase.gsub(/\s/, '_')
  end

  step '(I) (should) attach :name to the :name field' do |file_name, field|
    page.attach_file field, File.join(Rails.root, 'features', 'files', file_name)
  end

  step '(I) (should) (see) (a) link (called) :name' do |name|
    expect(page).to have_link name
  end

  step "I'm logged in" do
    login :dev
    visit root_path
  end
end
