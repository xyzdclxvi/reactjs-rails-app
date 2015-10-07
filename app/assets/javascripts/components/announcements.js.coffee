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
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Author'
            React.DOM.th null, 'Participants'

        for announcement in @state.announcements
          React.createElement Announcement, key: announcement.id, announcement: announcement, handleUserProfileClick: @handleUserProfileClick