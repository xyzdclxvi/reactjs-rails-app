@Announcement = React.createClass
  getInitialState: ->
    infoToggled: false
    fetchedFields: false
    author: 'a. placeholder'
    participants: 'p. placeholder'
  componentDidMount: ->
    console.log @props.announcement
    #@fetchAuthor({})
    #console.log @props.announcement.title + ": " + @props.announcement.id
  handleInfoToggle: (e) ->
    e.preventDefault()
    @setState infoToggled: !@state.infoToggled
    if !@state.fetchedFields
      @fetchParticipants()
      
  handleUserClick: (id) ->
    @props.handleUserProfileClick(id)
    
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
    
  render: ->
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
            #href: "/user/#{@props.announcement.user_id}"
            onClick: @handleUserClick.bind(this, @props.announcement.user_id)
            React.DOM.img
              className: 'thumb-small'
              src: if @props.announcement.author_image.length != 0 then @props.announcement.author_image else 'assets/placeholder-person.png'
              " " + @props.announcement.author_name
        React.DOM.td null, @props.announcement.participants_count
      if @state.infoToggled
        React.DOM.tr null,
          React.DOM.td null,
            @props.announcement.description   
          React.DOM.td colSpan: 2,
            for participant in @state.participants
              React.DOM.a
                #href: "/user/#{participant.id}"
                onClick: @handleUserClick.bind(this, participant.id)
                React.DOM.img
                  className: "thumb-small border-#{participant.status}"
                  src: if participant.image != null then participant.image else 'assets/placeholder-person.png'
                " " + participant.name + " "
