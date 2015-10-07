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
      className: 'user-profile'
      React.DOM.h4, null
        @state.user.name
      React.DOM.p null,
        "email: #{@state.user.email}"
      React.DOM.p null,
        for announcement in @state.announcements
          "#{announcement.title} "
      React.DOM.p null,
        for participation in @state.participations
          "#{participation.title} "
      React.DOM.a
        onClick: @handleClose
        'close'