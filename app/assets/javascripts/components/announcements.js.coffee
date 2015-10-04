@Announcements = React.createClass
  getInitialState: ->
    announcements: @props.data.announcements
    currentUser: @props.data.current_user
  getDefaultProps: ->
    announcements: []
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
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Author'
            React.DOM.th null, 'Participants'

        for announcement in @state.announcements
          React.createElement Announcement, key: announcement.id, announcement: announcement