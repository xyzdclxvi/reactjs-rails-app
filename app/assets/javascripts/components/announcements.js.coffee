@Announcements = React.createClass
  getInitialState: ->
    announcements: @props.data
  getDefaultProps: ->
    announcements: []
  render: ->
    React.DOM.div
      className: 'announcements'
      React.DOM.h2
        className: 'title'
        'Announcements'
      React.DOM.table
        className: 'table table-bordered'
        React.DOM.thead null,
          React.DOM.tr null,
            React.DOM.th null, 'Title'
            React.DOM.th null, 'Author'
            React.DOM.th null, 'Participants'

        for announcement in @state.announcements
          React.createElement Announcement, key: announcement.id, announcement: announcement