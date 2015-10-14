@Announcements = React.createClass
  getInitialState: ->
    announcements: @props.data.announcements
    currentUser: @props.data.current_user
    user_id: 0
    searchText: ""
  getDefaultProps: ->
    announcements: []
  
  handleUserProfileClick: (id) ->
    @setState user_id: id
    $('.cover').show()
  handleCloseProfile: ->
    @setState user_id: 0
    $('.cover').hide()
  handleSubmitAnnouncement: (announcement) ->
    #console.log "in announcements: submitted announcement"
    announcements = @state.announcements.slice()
    announcement.author_name = @state.currentUser.name
    if @state.currentUser.image
      announcement.author_image = @state.currentUser.image
    else
      announcement.author_image = ""
    announcement.participants_count = 0
    announcement.user_id = @props.data.current_user
    announcement.id = announcements[announcements.length - 1].id + 1 #this can produce wrong id but who cares lol
    #console.log announcement
    #console.log @state.announcements
    announcements.push announcement
    @setState announcements: announcements
    
  handleSearch: (query) ->
    #console.log "searched: " + query
    @setState searchText: query
    @setState user_id: 0
    $('.cover').hide()
  
  render: ->
    React.DOM.div
      className: 'announcements'
      React.DOM.h1
        className: 'title text-center'
        'Announcements'
      if @state.currentUser
        React.createElement AnnouncementForm, currentUser: @state.currentUser, handleSubmitAnnouncement: @handleSubmitAnnouncement, handleSearch: @handleSearch
      React.createElement SearchBar, searchText: @state.searchText, handleSearch: @handleSearch
      if @state.user_id != 0
        React.createElement UserProfile, key: @state.user_id, user_id: @state.user_id, handleCloseProfile: @handleCloseProfile, handleSearch: @handleSearch
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Author'
            React.DOM.th null, 'Participants'

        for announcement in @state.announcements
          React.createElement Announcement, key: announcement.id, announcement: announcement, handleUserProfileClick: @handleUserProfileClick, currentUser: @state.currentUser, searchText: @state.searchText