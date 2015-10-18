# time_offs.js.coffee

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
    filterable: true
    pageable:
      refresh: true
      pageSizes: true
      buttonCount: 5
    columns: [
      {
        field: 'id',
        title: 'Request #'
      },
      {
        field: 'request_type_name',
        title: 'Type'
      },
      {
        field: 'request_start_date',
        title: 'Start On',
        template: '#= kendo.toString(kendo.parseDate(request_start_date, \'yyyy-MM-dd\'), \'MM/dd/yyyy\') #'
      },
      {
        field: 'request_end_date',
        title: 'Back On',
        template: '#= kendo.toString(kendo.parseDate(request_end_date, \'yyyy-MM-dd\'), \'MM/dd/yyyy\') #'
      },
      {
        field: 'status',
        title: 'Status',
        template: '#= status.charAt(0).toUpperCase() + status.substring(1) #'
      },
      {
        field: 'users_name',
        title: 'User'
      },
      {
        field: 'comments'
        title: 'Comments'
        filterable: cell: operator: 'contains'
      }
    ]
  return

# Form Validations
judgeValidateForm $('#new_time_off')