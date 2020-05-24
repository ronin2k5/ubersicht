# command: "/usr/local/bin/npm outdated | awk '{print $1;}'"
command: """
          outdated-node-packages/outdatednodes.sh
"""
# command: "/usr/local/lib/node_modules/npm/bin/npm-cli.js outdated | awk '{print $1;}'"

refreshFrequency: 3600000 # 60 minutes by default

style: """
  // Position the widget on your screen
  top 400px
  left 1500px

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
"""

render: -> """
  <div class="container">
    <div class="widget-title">Outdated Ports</div>
    <div id="npm" class="list">
    </div>
  </div>
"""

update: (output, domElement) ->
  
  domElement.innerHTML = '<div class="container"><div class="widget-title">Outdated Node Packages</div><div id="npm" class="list"></div></div>'
  
  npms = output.split('\n')
  list = $(domElement).find('#npm')
  
  addnpm = (npm) ->
    item = "<div class=\"list-item\">#{npm}</div>"
    list.append item
  
  if npms.length == 0
    addnpm "No outdated npm packages!"
  else
    for npm, i in npms
      addnpm npm
