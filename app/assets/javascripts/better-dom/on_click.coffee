# DOM.extend '[on-click-load]',
#   constructor: ->
#     @on 'click', @clicked
#
#   clicked: ->
#     url = @get 'on-click'
#
#     $.ajax url: url
#
#     false # Prevent default action
