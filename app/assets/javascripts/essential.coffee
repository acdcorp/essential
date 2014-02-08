#= require jquery/jquery
#= require bootstrap
#= require turbolinks
#= require jquery.turbolinks
#= require turbolinks.redirect
#= require bootbox/bootbox
#= require lodash/dist/lodash.js
#= require input_mask
#= require moment
#= require bootstrap-datetimepicker

essentialAttrList =
  '[on-change-get]':
    change: (url) -> $.ajax url: "#{url}&value=#{@val()}"

  '[on-click-get]':
    click: (url) -> $.ajax url: url

  '[toggle-sidebar]':
    init: ->
      @key = 'toggled-sidebar'
      @data @key, true

    click: (id) ->
      $sidebar = $ "##{id}"
      $content = $ "#content"

      if @data @key
        $sidebar.hide()
        @removeData @key
        $content.css
          margin: '0'
          width: '100%'
      else
        $sidebar.show()
        @data @key, true
        $content.css
          margin: ''
          width: ''

  # Stop main button from closing dialog and make it submit the visible form
  'body > .bootbox .modal-footer > .btn-primary':
    click: ->
      @closest('.modal-content').find('.bootbox-body form:visible').submit()

  # Close the modal if the background is clicked
  'body > .bootbox.modal':
    click: ->
      unless  $('.modal-content:hover').length
        bootbox.hideAll()

  '[mask]':
    init: (mask) ->
      @inputmask mask: mask, placeholder: @attr('placeholder')

  '[date]':
    init: (format) ->
      @datetimepicker
        pickTime: false

$ ->
  # Load all the live attr events
  for selector, events of essentialAttrList
    for event, func of events
      unless event == 'init'
        essentialAttr selector, event,
          init: events.init
          trigger: func

# The magic method
window.essentialAttr = (selector, event, callback) ->
  addAttr = ->
    attr = selector.replace(/[^a-zA-Z-]/g, '')
    key  = "essentialAttr-#{attr}-#{event}"

    $(selector).each ->
      $el = $ @

      unless $el.data key
        callback.init?.call $el, $el.attr attr

        unless event is 'init'
          $el.bind event, ->
            callback.trigger?.call $el, $el.attr attr
            false

        $el.data key, true

  addAttr()
  $(document).on 'page:change', -> addAttr()
