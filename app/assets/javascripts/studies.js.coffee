$(document).on "page:fetch", ->
  NProgress.start()
  return

$(document).on "page:change", ->
  NProgress.done()
  return

$(document).on "page:restore", ->
  NProgress.remove()
  return
