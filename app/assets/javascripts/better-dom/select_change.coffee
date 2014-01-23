DOM.extend '[select-change]',
  constructor: ->
    @on 'change', @valueChanged

  valueChanged: ->
    url   = @get 'select-change'
    value = @get 'value'

    $.ajax url: "#{url}&value=#{value}"
