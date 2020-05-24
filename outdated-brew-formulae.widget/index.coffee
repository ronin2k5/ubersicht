#WRS-202002251430: added line in output to display instructions for updating, and related style
command: "/usr/local/bin/brew update > /dev/null && /usr/local/bin/brew outdated"
#command: "/usr/local/bin/brew outdated"

refreshFrequency: 3600000 # 60 minutes by default

style: """
  // Position the widget on your screen
  top 400px
  left 1050px

  // Change the style of the widget
  color #fff
  font-family Helvetica Neue
  background rgba(#000, .5)
  padding 10px 10px 5px
  border-radius 5px

  .container
    position: relative
    clear: both

  .list
    padding-top: 3px
    width=100%
    
  .list-item
    font-size: 8px
    font-weight: 300
    color: rgba(#fff, .9)
    text-shadow: 0 1px 0px rgba(#000, .7)

  .widget-title
    font-size 10px
    text-transform uppercase
    font-weight bold

  .howtoupdate
    font-size 9px
    color: rgba(#ff0, 1)
"""

render: -> """
  <div class="container">
    <div class="widget-title">Outdated Brew Formulae</div>
    <div id="formulae" class="list">
    </div>
  </div>
"""

update: (output, domElement) ->
  
  domElement.innerHTML = '<div class="container"><div class="widget-title">Outdated Brew Formulae</div><div class="howtoupdate">Update with:<br />brew update && brew upgrade</div><div id="formulae" class="list"></div></div>'
  
  formulae = output.split('\n')
  list = $(domElement).find('#formulae')
  
  addFormula = (formula) ->
    item = "<div class=\"list-item\">#{formula}</div>"
    list.append item
  
  if formulae.length == 0
    addFormula "No outdated formulae!"
  else
    for formula, i in formulae
      addFormula formula
