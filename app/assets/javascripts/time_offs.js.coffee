# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

timeOffCrudSrvBaseUrl = '/time_offs'
timeOffDataSource = new (kendo.data.DataSource)(
  transport:
    read:
      url: timeOffCrudSrvBaseUrl
      dataType: 'json'
    create:
      url: timeOffCrudSrvBaseUrl
      dataType: 'json'
      contentType: 'application/json'
      type: 'POST'
    update:
      url: (data) ->
        timeOffCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      contentType: 'application/json'
      type: 'PUT'
    destroy:
      url: (data) ->
        timeOffCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      type: 'DELETE'
    parameterMap: (data, operation) ->
      return
  schema: model:
    id: 'id'
    fields:
      comments:
        type: 'string'
  pageSize: 20)

$(document).ready ->

  $('#timeOffGrid').kendoGrid
    dataSource: timeOffDataSource
    height: 450
    sortable: true
    filterable: mode: 'row'
    pageable:
      refresh: true
      pageSizes: true
      buttonCount: 5
    columns: [
      {
        field: 'comments'
        title: 'Comments'
        filterable: cell: operator: 'contains'
      }
    ]
  return