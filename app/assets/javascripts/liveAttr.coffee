#= require pt/sugar/release/sugar-full.development

window.liveAttr = (selector, event, callback) ->
  $ ->
    regex    = new RegExp "[\s\.\>]", "g"
    key      = "liveAttr-#{selector.replace(regex, '-')}"

    if selector.has(regex)
      attr      = ''
      jSelector = selector
    else
      attr      = selector
      jSelector = "[#{selector}]"

    addAttr = ->
      $(jSelector).each ->
        $el = $ @

        unless $el.data key
          callback.init?.call $el

          $el.bind event, ->
            $this = $ @
            callback.trigger.call $this, $this.attr(attr)
            false

          $el.data key, true

    addAttr()
    $(document).on 'page:change', -> addAttr()

### Events ###
liveAttr 'on-change-get', 'change',
  trigger: (url) -> $.ajax url: "#{url}&value=#{@val()}"

liveAttr 'on-click-get', 'click',
  trigger: (url) -> $.ajax url: url

### bootbox ###

# Stop main button from closing dialog and make it submit the visible form
liveAttr 'body > .bootbox .modal-footer > .btn-primary', 'click',
  trigger: ->
    @closest('.modal-content').find('.bootbox-body form:visible').submit()

# Close the modal if the background is clicked
liveAttr 'body > .bootbox.modal', 'click',
  trigger: ->
    unless  $('.modal-content:hover').length
      bootbox.hideAll()
