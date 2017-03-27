command: "/usr/local/bin/istats --no-graphs"

refreshFrequency: 1000

style: """
    //Position this where you want
    top 20px
    left 425px
//    width 450px
//    height 600px
    background: #000
    color: rgba(#fff, 0.5)
// 	font-family: Helvetica Neue
//	font-size: 15px
//	font-weight: bold

    .sectionname
        color: #08f
        background: rgba(#fff, 0.25)

    table
        border-collapse: collapse

    table, td
        border: 1px solid rgba(#fff, 0.25)
//        border-radius 10px   
 
"""

parseKeyValue: (sectiondata) ->
    kvpair = {}
    vals = sectiondata.split(":")

    kvpair.key = vals[0]
    kvpair.value = vals[1]

    kvpair

parseSection: (sectionname, sectiondata) ->
    section = {}
    section.name = sectionname
    section.data = []

    for sd in sectiondata
        if sd && !sd.match(/(\r|\n)/)
            section.data.push(@parseKeyValue(sd))

    section

parseOutput: (output) ->
    lines = output.split("\n")
    sections = []

    while lines.length > 0
        line = lines.shift()

        if !line || line.match(/(\r|\n)/)
            continue

        if line.indexOf(/---.*?/)
            sectionname = line.replace(/---\s+(.*?)\s+---/, '$1')
            sectiondata = []
            
            while line && !line.match(/(\r|\n)/)
                line = lines.shift()
                sectiondata.push(line)

            sections.push(@parseSection(sectionname, sectiondata))

    sections

formatOutput: (output) ->
    html = ""
    sections = @parseOutput(output)

    for section in sections
        html += "<tr>"
        html += "<td colspan='2' class='sectionname'>" + section.name + " ("  + section.data.length + ")" + "</td>"
        html += "</tr>"

        for kvpair in section.data
            html += "<tr>"
            html += "<td>" + kvpair.key + "</td>"
            html += "<td class='" + kvpair.key.replace(/\s/g, '-').replace(/\//g, '-').replace(/\?/g, '') + "-class'>" + kvpair.value + "</td>"
            html += "</tr>"

    html

render: (output) ->
    html = "<table class='istatsinfo'>"

    html += @formatOutput(output)

    html += "</table>"

update: (output, domEl) ->
    sections = @parseOutput(output)

    for section in sections
        for kvpair in section.data
            $(domEl).find("." + kvpair.key.replace(/\s/g, '-').replace(/\//g, '-').replace(/\?/g, '') + "-class").text kvpair.value
