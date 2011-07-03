# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

currentChar=0
content=""
clock=-1
clockId=0

replaceTypewriter = (chars) ->
  body = $("body").width() / 2 - 10
  body -= 20*chars
  # console.log(body, chars)
  $("#progress progress").attr("value", chars)
  if currentChar == content.length
    clearInterval(clockId)
    $("#typewriter ul").animate({"left": "-=250px"}, 500, submitResult)
  else
    $("#typewriter ul").animate({"left": body+"px"}, 50)

updateClock = () ->
  clock++
  $("span#time").text((clock-(clock%10))/10 + "." + clock%10 + " s")

submitResult = () ->
  $("#submit").fadeIn ()->
    $("#submit form").children("input:first").focus()
  $("#submit form").submit (e) ->
    e.preventDefault()
    $.ajax
      type: 'POST'
      url: document.URL + '/create'
      data:
        result:
          name: $("#submit form").children("input:first").attr("value")
          time: clock
      dataType: "html"
      success: (data)->
        # console.log(data)
        $("#typing_box").fadeOut ()->
          $("#typing_box").html(data)
          $("#typing_box").fadeIn ()->
            $(".start_button").focus()
  
prepareTypewriter = () ->
  $.get document.URL.replace("/type", ".json"), (data)->
    content = data.body.replace(/\s+/g, " ")
    # console.log(content)
    currentChar = 0
    replaceTypewriter(currentChar)
    $("#typewriter ul").css("width", 20*content.length + 500)
    form = $("#typewriter ul li:first")
    form.remove()
    for i in [0..content.length-1]
      $("#typewriter ul").append("<li>" + content[i] + "</li>")
    $("#typewriter ul").append(form)
    $("#typewriter ul li:last").hide()
    $("#typewriter ul").animate {"left": $("body").width()/2 -10}, 500
    $("#typewriter ul li:first").attr("class", "current")

    $(document).keypress (event)->
      return if event.which < 32 && event.which > 126
      character = String.fromCharCode(event.which)
      # console.log(event.which)
      if character == content[currentChar]
        if clockId == 0
          $("#hint").hide()
          $("#progress").show()
          clockId = setInterval(updateClock, 100)
          updateClock()
          $("#progress progress").attr("max", content.length)
          $("#progress progress").attr("value", 0)
        $("#typewriter ul li:nth-child(" + (currentChar+1) + ")").attr("class", "correct")
        $("#typewriter ul li:nth-child(" + (currentChar+2) + ")").attr("class", "current")
        currentChar++
        replaceTypewriter(currentChar)
      else if currentChar < content.length
        $("#typewriter ul li:nth-child(" + (currentChar+1) + ")").attr("class", "wrong")

$(document).ready ()->
  if document.URL.match(/\/type/).length != 0
    $("#typewriter ul").css("left", $("body").width())
    prepareTypewriter() 
    $(window).resize ()->
      $("#container").css("height", $(window).height() - $("#header").height() - 70)
      $("#typing_box").css("top", $("#container").height()/2 - $("#typing_box").height()/2 - 70)
    $(window).resize()
      
