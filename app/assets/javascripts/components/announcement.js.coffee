@Announcement = React.createClass
  getInitialState: ->
    infoToggled: false
    fetchedFields: false
    author: 'a. placeholder'
    participants: 'p. placeholder'
  componentDidMount: ->
    #@fetchAuthor({})
    #console.log @props.announcement.title + ": " + @props.announcement.id
  handleInfoToggle: (e) ->
    e.preventDefault()
    @setState infoToggled: !@state.infoToggled
    if !@state.fetchedFields
      @fetchParticipants()
    
  fetchAuthor: (data) ->
    $.ajax
      url: "announcements/#{@props.announcement.id}/author"
      dataType: 'json'
      data: data
    .done @fetchedAuthor
  fetchedAuthor: (data, textStatus, jqXHR) ->
    @setState author: data
    
  fetchParticipants: (data) ->
    $.ajax
      url: "announcements/#{@props.announcement.id}/participants"
      dataType: 'json'
      data: data
    .done @fetchedParticipants
  fetchedParticipants: (data, textStatus, jqXHR) ->
    @setState participants: data  
    console.log @state.participants
    @setState fetchedFields: true;
    
  defaultView: ->  
    React.DOM.tbody null,
      React.DOM.tr null,
        React.DOM.td null,
          @props.announcement.title
          React.DOM.a
            className: 'btn btn-default'
            onClick: @handleInfoToggle
            'View'
        React.DOM.td null,
          React.DOM.a
            href: "/users/#{@props.announcement.user_id}"
            @props.announcement.author_name
        React.DOM.td null, @props.announcement.participants_count
      
  toggledView: ->
    React.DOM.tbody null,
      React.DOM.tr null,
        React.DOM.td null,
          @props.announcement.title
          React.DOM.a
            className: 'btn btn-default'
            onClick: @handleInfoToggle
            'View'
        React.DOM.td null, 
          React.DOM.a
            href: "/users/#{@props.announcement.user_id}"
            @props.announcement.author_name
        React.DOM.td null, @props.announcement.participants_count
      React.DOM.tr null,
        React.DOM.td null,
          @props.announcement.description   
        React.DOM.td colSpan: 2,
          for participant in @state.participants
            React.DOM.a
              href: "/users/#{participant.id}"
              participant.name + " "
    
  render: ->
    if @state.infoToggled
      @toggledView()
    else
      @defaultView()
