@Announcements = React.createClass
  getInitialState: ->
    announcements: @props.data.announcements
    currentUser: @props.data.current_user
    user_id: 0
  getDefaultProps: ->
    announcements: []
  
  handleUserProfileClick: (id) ->
    @setState user_id: id
  handleCloseProfile: ->
    @setState user_id: 0
  handleSubmitAnnouncement: (announcement) ->
    console.log "in announcements: submitted announcement"
    announcements = @state.announcements.slice()
    announcement.author_name = @state.currentUser.name
    if @state.currentUser.image
      announcement.author_image = @state.currentUser.image
    else
      announcement.author_image = ""
    announcement.participants_count = 0
    console.log announcement
    console.log @state.announcements
    announcements.push announcement
    @setState announcements: announcements
  
  render: ->
    React.DOM.div
      className: 'announcements'
      React.DOM.h2
        className: 'title'
        'Announcements'
      if @state.currentUser
        React.DOM.p null,
          'logged in as: '
          React.DOM.a
            href: "user/#{@state.currentUser.id}"
            @state.currentUser.name
      else
        React.DOM.p null,
          'not logged in'
      if @state.user_id != 0
        React.createElement UserProfile, key: @state.user_id, user_id: @state.user_id, handleCloseProfile: @handleCloseProfile
      if @state.currentUser
        React.createElement AnnouncementForm, currentUser: @state.currentUser, handleSubmitAnnouncement: @handleSubmitAnnouncement
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Author'
            React.DOM.th null, 'Participants'

        for announcement in @state.announcements
          React.createElement Announcement, key: announcement.id, announcement: announcement, handleUserProfileClick: @handleUserProfileClick, currentUser: @state.currentUser