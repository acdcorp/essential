# DOM.extend '[on-change-load]',
#   constructor: ->
#     @on 'change', @valueChanged
#
#   valueChanged: ->
#     url   = @get 'on-change'
#     value = @get 'value'
#
#     $.ajax url: "#{url}&value=#{value}"
