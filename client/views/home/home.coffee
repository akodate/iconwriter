@Table = new Meteor.Collection(null)

@table = {}
@table['rows'] = []
row1 = {}
row1['letters'] = ['a', 'b', 'c', 'd']
row2 = {}
row2['letters'] = ['d', 'c', 'b', 'a']
@table['rows'].push row1, row2

Table.insert(@table)

Template.home.events
  "keydown .writing-box": (event, ui) ->
    if (event.keyCode == 13 && !event.shiftKey)
      event.preventDefault()
      event.stopPropagation()
      console.log "Submitted."
      text = $('.writing-box')[0].value
      console.log text
      generateTable(text)
      false
    else if event.keyCode != 13
      true
    else
      event.preventDefault()
      event.stopPropagation()
      false

Template.home.helpers

  table: ->
    console.log Table.findOne({})
    Table.findOne({})

@generateTable = (text) ->
  rows = []
  while text.length > 0 && rows.length < 5
    rows.push {}
    rows[rows.length - 1]['letters'] = []
    for [0..3]
      if text.length > 0
        rows[rows.length - 1]['letters'].push(text[0])
        text = text.slice(1)
  console.log rows
  Table.update({}, {rows})

