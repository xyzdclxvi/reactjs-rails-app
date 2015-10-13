$(document).ready ->
  (->
    actual_height = $('.container-narrow').height()
    desired_height = $(window).height()
    if actual_height > desired_height
      return
    $('.page-stretcher').css 'height', desired_height - actual_height - 20
    return
  ).call this


