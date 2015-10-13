@UserProfile = React.createClass
  getInitialState: ->
    user_id: @props.user_id
    user: {}
    announcements: []
    participations: []
  componentDidMount: ->
    @fetchProfileData()
    
  handleClose: ->
    @props.handleCloseProfile()
    
  handleClickAnnouncement: (e) ->
    @props.handleSearch($(e.target).text())
    
  fetchProfileData: ->
    @fetchUser({})
    @fetchAnnouncements({})
    @fetchParticipations({})
    
  fetchUser: (data) ->
    $.ajax
      url: "user/#{@state.user_id}/user_json"
      dataType: 'json'
      data: data
    .done @fetchedUser
  fetchedUser: (data, textStatus, jqXHR) ->
    @setState user: data
  
  fetchAnnouncements: (data) ->
    $.ajax
      url: "user/#{@state.user_id}/announcements"
      dataType: 'json'
      data: data
    .done @fetchedAnnouncements
  fetchedAnnouncements: (data, textStatus, jqXHR) ->
    @setState announcements: data
    console.log @state.announcements
    
  fetchParticipations: (data) ->
    $.ajax
      url: "user/#{@state.user_id}/participants"
      dataType: 'json'
      data: data
    .done @fetchedParticipations
  fetchedParticipations: (data, textStatus, jqXHR) ->
    @setState participations: data 
    console.log @state.participations
    
  render: ->
    React.DOM.div
      className: 'popout-window'
      React.DOM.img
        className: 'thumb-larger'
        src: if @state.user.image then @state.user.image else 'assets/placeholder-person.png'

      React.DOM.h4 null,
        @state.user.name
      React.DOM.p null,
        @state.user.email
      React.DOM.br null
      React.DOM.p null,
        'Announcements: '
        for announcement in @state.announcements
          React.DOM.a
            className: 'little-right-margin'
            onClick: @handleClickAnnouncement
            announcement.title
      React.DOM.p null,
        'Participates in: '
        for participation in @state.participations
          React.DOM.a
            className: 'little-right-margin'
            onClick: @handleClickAnnouncement
            participation.title
      React.DOM.h4
        className: 'cursor-pointer'
        onClick: @handleClose
        '[close]'