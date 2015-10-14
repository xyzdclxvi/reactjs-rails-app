@SearchBar = React.createClass
  getInitialState: ->
    searchText: @props.searchText
    
  componentWillReceiveProps: (props) ->
    @setState searchText: props.searchText
    
  handleChangeText: (e) ->
    @setState searchText: e.target.value
    @props.handleSearch(e.target.value)
    
  render: ->
    React.DOM.form
      className: 'form col-lg-6'
      React.DOM.div
        className: 'form-group'
        React.DOM.input
          type: 'text'
          className: 'form-control'
          placeholder: 'Search...'
          name: 'search'
          value: @state.searchText
          onChange: @handleChangeText
