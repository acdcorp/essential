#= require jquery
#= require jquery_ujs
#= require bootstrap
#= require turbolinks
#= require jquery.turbolinks
#= require turbolinks.redirect
#= require bootbox/bootbox
#= require lodash/dist/lodash.js
#= require input_mask
#= require moment
#= require bootstrap-datetimepicker

toggleSubNav = ->
  if @data @key
    @parent().find('ul').slideDown()
    @parent().addClass 'active'
  else
    @parent().removeClass 'active'
    @parent().find('ul').slideUp()
    @removeData @key

essentialAttrList =
  '[on-change-get]':
    change: (url) -> $.ajax url: "#{url}&value=#{@val()}"

  '[on-click-get]':
    click: (url) -> $.ajax url: url

  '[toggle-subnav]':
    init: ->
      @key = 'toggled-subnav'
      @data @key, (if @parent().hasClass('active') then true else false)

    click: (id) ->
      unless @parent().hasClass 'active'
        @closest('ul').find('li a').removeClass 'active-on-load'
        @closest('ul').find('li').removeClass 'active'
        @closest('ul').find('li i.pull-right').removeClass 'fa-caret-down'
        @closest('ul').find('li i.pull-right').addClass 'fa-caret-left'
        @closest('ul').find('ul').slideUp()
        @parent().find('i.pull-right').removeClass 'fa-caret-left'
        @parent().find('i.pull-right').addClass 'fa-caret-down'
        @data @key, true
        toggleSubNav.call @

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

  # 'form[data-remote]':
  #   submit: -> $.ajax method: @attr('method'), url: @attr('action')

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
