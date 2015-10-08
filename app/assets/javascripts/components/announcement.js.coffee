@Announcement = React.createClass
  getInitialState: ->
    infoToggled: false
    fetchedFields: false
    author: 'a. placeholder'
    participants: 'p. placeholder'
  componentDidMount: ->
    @setState participants_count: @props.announcement.participants_count
    console.log @props
    #@fetchAuthor({})
    #console.log @props.announcement.title + ": " + @props.announcement.id
  handleInfoToggle: (e) ->
    e.preventDefault()
    @setState infoToggled: !@state.infoToggled
    if !@state.fetchedFields
      @fetchParticipants()
  handleUserClick: (id) ->
    @props.handleUserProfileClick(id)
    
  handleParticipate: (e) ->
    console.log "zrobic zapis na #{@props.announcement.id}"
    $.ajax
      method: 'POST'
      url: "announcements/#{@props.announcement.id}/add"
      dataType: 'json'
      success: =>
        @fetchParticipants()
  
  handleRemove: (e) ->
    $.ajax
      method: 'DELETE'
      url: "announcements/#{@props.announcement.id}/remove"
      dataType: 'json'
      success: () =>
        @fetchParticipants()

  handleAccept: (id) ->
    $.ajax
      method: 'PUT'
      url: "announcements/#{@props.announcement.id}/accept/#{id}"
      dataType: 'json'
      success: () =>
        @fetchParticipants()
        
  handleReject: (id) ->
    $.ajax
      method: 'PUT'
      url: "announcements/#{@props.announcement.id}/reject/#{id}"
      dataType: 'json'
      success: () =>
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
    @setState participants_count: @state.participants.length
    
  render: ->
    React.DOM.tbody null,
      React.DOM.tr null,
        React.DOM.td null,
          React.DOM.a
            className: 'btn btn-default margin-right'
            onClick: @handleInfoToggle
            'View'
          @props.announcement.title
        React.DOM.td null, 
          React.DOM.div
            className: 'dropdown'
            React.DOM.a
              className: 'dropdown-toggle'
              'data-toggle': 'dropdown'
              React.DOM.img
                className: 'thumb-small'
                src: if @props.announcement.author_image.length != 0 then @props.announcement.author_image else 'assets/placeholder-person.png'
                " " + @props.announcement.author_name
            React.DOM.ul
              className: 'dropdown-menu'
              React.DOM.li
                className: 'wtf'
                React.DOM.a
                  onClick: @handleUserClick.bind(this, @props.announcement.user_id)
                  "Profile"
              React.DOM.li
                className: 'wtf'
                React.DOM.a
                  onClick: null 
                  "some crap"
    
        React.DOM.td null, @state.participants_count
      
      if @state.infoToggled
        React.DOM.tr null,
          React.DOM.td null,
            @props.announcement.description
            if @props.currentUser
              React.DOM.p null,
                React.DOM.a
                  className: 'btn btn-primary'
                  onClick: @handleParticipate
                  'Enter'
          React.DOM.td colSpan: 2,
            for participant in @state.participants
              React.DOM.div
                className: 'dropdown'
                React.DOM.a
                  className: 'dropdown-toggle'
                  'data-toggle': 'dropdown'
                  onClick: null
                  React.DOM.img
                    className: "thumb-small border-#{participant.status}"
                    src: if participant.image != null then participant.image else 'assets/placeholder-person.png'
                  " " + participant.name + " "
                if @props.currentUser && @props.currentUser.id == @props.announcement.user_id 
                  React.DOM.ul
                    className: 'dropdown-menu'
                    React.DOM.li
                      className: 'wtf'
                      React.DOM.a
                        onClick: @handleUserClick.bind(this, participant.id)
                        "Profile"
                    if @props.currentUser.id == participant.id
                      React.DOM.li
                        className: 'wtf'
                        React.DOM.a
                          onClick: @handleRemove
                          "Remove"  
                    React.DOM.li
                      className: 'divider'
                    React.DOM.li
                      className: 'wtf'
                      React.DOM.a
                        onClick: @handleAccept.bind(this, participant.id)
                        "Accept"
                    React.DOM.li
                      className: 'wtf'
                      React.DOM.a
                        onClick: @handleReject.bind(this, participant.id)
                        "Reject"   

 
                else
                  React.DOM.ul
                    className: 'dropdown-menu'
                    React.DOM.li
                      className: 'wtf'
                      React.DOM.a
                        onClick: @handleUserClick.bind(this, participant.id)
                        "Profile"
                    if @props.currentUser.id == participant.id
                      React.DOM.li
                        className: 'wtf'
                        React.DOM.a
                          onClick: @handleRemove
                          "Remove"
                        
