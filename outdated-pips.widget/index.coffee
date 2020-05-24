command: "/usr/local/bin/pip3 list --outdated | awk '{print $1;}'"
#command: "/usr/local/bin/brew outdated"

refreshFrequency: 3600000 # 60 minutes by default

style: """
  // Position the widget on your screen
  top 30px
  left 1250px

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
    <div class="widget-title">Outdated PIPs</div>
    <div id="ports" class="list">
    </div>
  </div>
"""

update: (output, domElement) ->
  
  domElement.innerHTML = '''<div class="container"><div class="widget-title">Outdated PIPs</div><div class="howtoupdate">Update with:<br />sudo pip3 list --outdated  | awk '{printf "%s",$1;printf "==";print $3}' > temp.txt; sed '1d' temp.txt > temp2.txt;sed '1d' temp2.txt > requirements.txt && pip3 install --upgrade -r requirements.txt</div><div id="pips" class="list"></div></div>'''
  
  pips = output.split('\n')
  list = $(domElement).find('#pips')
  
  addpip = (pip) ->
    item = "<div class=\"list-item\">#{pip}</div>"
    list.append item
  
  if pips.length == 0
    addpip "No outdated pips!"
  else
    for pip, i in pips
      addpip pip
