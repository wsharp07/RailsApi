timeOffRequestTypesCrudSrvBaseUrl = '/request_types'
timeOffRequestTypesDataSource = new (kendo.data.DataSource)(
  transport:
    read:
      url: timeOffRequestTypesCrudSrvBaseUrl
      dataType: 'json'
    create:
      url: timeOffRequestTypesCrudSrvBaseUrl
      dataType: 'json'
      contentType: 'application/json'
      type: 'POST'
    update:
      url: (data) ->
        timeOffRequestTypesCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      contentType: 'application/json'
      type: 'PUT'
    destroy:
      url: (data) ->
        timeOffRequestTypesCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      type: 'DELETE'
    parameterMap: (data, operation) ->
# parameters sent on create
      if operation == 'create'
# only send the name parameter
        return kendo.stringify(name: data.name)
      # parameters sent on update
      if operation == 'update'
        return kendo.stringify(
          id: data.id
          name: data.name)
      return
  schema: model:
    id: 'id'
    fields:
      id: editable: false
      name:
        type: 'string'
        validation: required: true
      created_at:
        type: 'date'
        editable: false
      updated_at:
        type: 'date'
        editable: false
  pageSize: 20)


$(document).ready ->

  $('#timeOffRequestTypesGrid').kendoGrid
    dataSource: timeOffRequestTypesDataSource
    height: 450
    toolbar: [ 'create' ]
    sortable: true
    filterable: mode: 'row'
    pageable:
      refresh: true
      pageSizes: true
      buttonCount: 5
    columns: [
      {
        field: 'name'
        title: 'Request Type'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'created_at'
        title: 'Created At'
        template: '#= kendo.toString(kendo.parseDate(created_at, \'yyyy-MM-dd\'), \'MM/dd/yyyy\') #'
      }
      {
        field: 'updated_at'
        title: 'Updated At'
        template: '#= kendo.toString(kendo.parseDate(updated_at, \'yyyy-MM-dd\'), \'MM/dd/yyyy\') #'
      }
      {
        command: [
          'edit'
          'destroy'
        ]
        title: '&nbsp;'
        width: '250px'
      }
    ]
    editable: 'inline'
  return