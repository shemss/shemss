queryStringToObject = ->
  pairs = (location.href.split("#")[1] || '').split('&')

  result = {}
  $.each pairs, ->
    pair = this.split('=')
    result[pair[0]] = decodeURIComponent((pair[1] || '').replace(/\+/g, ' '))

  result


navigateToTabWithForm = ->
  queryString = queryStringToObject()
  return unless queryString.fi

  $form = $("form[action$='/#{queryString.fi}']")
  return unless $form.length

  tabId = $form.closest('.tab-pane').attr('id')
  $("[href='##{tabId}']").tab('show')


$ navigateToTabWithForm
