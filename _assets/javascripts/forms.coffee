setupDateTimeInputs = (inputType, widgetFunction) ->
  $("input[type=\"#{inputType}\"]").each ->
    $input = $(this)
    $label = $("label[for='#{$input.attr('id')}']")
    $dt_input = $('<input class="form-control" type="text">')
    dt_input_id = "#{$input.attr('id')}_dt_selector"

    $dt_input.attr('id', dt_input_id)
    $dt_input.addClass(inputType)

    widgetFunction($dt_input, $input)
    $input.change()

    $label.attr('for', dt_input_id)
    $input.hide().after($dt_input)


dateHandler = (picker, input) ->
  $(picker).change ->
    $(input).val($(this).datepicker('getDate').toISOString().split('T')[0])

  $(picker).datepicker
    autoclose: true
    format: 'M d, yyyy'

  $(input).change ->
    return unless $(this).val()

    try
      d = $(this).val().split('-')
      $(picker).datepicker 'update', "#{d[1]} #{d[2]}, #{d[0]}"
    catch e
      console.log e


inputIsCorrectType = (inputType) ->
  elem = document.createElement('input')
  elem.setAttribute('type', inputType)
  elem.type == inputType


inputIsEnabled = (inputType) ->
  elem = document.createElement('input')
  elem.setAttribute('type', inputType)
  !elem.disabled


inputTypes = [
    inputType: 'date'
    polyfill: -> setupDateTimeInputs('date', dateHandler)
  ,
    inputType: 'file'
    inputTest: inputIsEnabled
    polyfill: -> $('input:file').hide()
]

initForms = ->
  $(inputTypes).each ->
    if (this.inputTest || inputIsCorrectType)(this.inputType)
      this.nativeInit() if (this.nativeInit)
    else
      this.polyfill() if (this.polyfill)


$ initForms
