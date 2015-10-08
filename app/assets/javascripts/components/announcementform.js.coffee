@AnnouncementForm = React.createClass
  getInitialState: ->
    title: ''
    description: ''
    
  handleSubmit: (e) ->
    e.preventDefault()
    $.ajax
      method: 'POST'
      url: "announcements"
      dataType: 'json'
      data: { announcement: @state }
      success: =>
        @props.handleSubmitAnnouncement(@state)   

  handleChangeTitle: (e) ->
    @setState title: e.target.value
    
  handleChangeDescription: (e) ->
    @setState description: e.target.value  
    
  valid: ->
    @state.title && @state.description
    
  render: ->
    React.DOM.form
      className: 'form'
      onSubmit: @handleSubmit
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Title'
          name: 'title'
          value: @state.title
          onChange: @handleChangeTitle
      React.DOM.br
      React.DOM.div
        className: 'form-group'
        React.DOM.textarea
          type: 'text'
          className: 'form-control'
          placeholder: 'Description'
          name: 'description'
          value: @state.description
          onChange: @handleChangeDescription
      React.DOM.br
      React.DOM.button
        type: 'submit'
        className: 'btn btn-primary'
        disabled: !@valid()
        'Submit'
        