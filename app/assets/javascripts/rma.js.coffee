# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

hardwareTypeCrudSrvBaseUrl = '/hardware_types'
hardwareTypeDataSource = new (kendo.data.DataSource)(
  transport:
    read:
      url: hardwareTypeCrudSrvBaseUrl
      dataType: 'json'
    create:
      url: hardwareTypeCrudSrvBaseUrl
      dataType: 'json'
      contentType: 'application/json'
      type: 'POST'
    update:
      url: (data) ->
        hardwareTypeCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      contentType: 'application/json'
      type: 'PUT'
    destroy:
      url: (data) ->
        hardwareTypeCrudSrvBaseUrl + '/' + data.id
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

rmaCrudSrvBaseUrl = '/rmas'
rmaDataSource = new (kendo.data.DataSource)(
  transport:
    read:
      url: rmaCrudSrvBaseUrl
      dataType: 'json'
    create:
      url: rmaCrudSrvBaseUrl
      dataType: 'json'
      contentType: 'application/json'
      type: 'POST'
    update:
      url: (data) ->
        rmaCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      contentType: 'application/json'
      type: 'PUT'
    destroy:
      url: (data) ->
        rmaCrudSrvBaseUrl + '/' + data.id
      dataType: 'json'
      type: 'DELETE'
    parameterMap: (data, operation) ->
      return
  schema: model:
    id: 'id'
    fields:
      rma_number:
        type: 'string'
      serial_number:
        type: 'string'
      reference_number:
          type: 'string'
      tracking_number:
        type: 'string'
      comments:
        type: 'string'
      hardware_type_name:
        type: 'string'
      created_at:
        type: 'date'
      updated_at:
        type: 'date'
  pageSize: 20)


$(document).ready ->

  # Reset Button Click
  $('#btn-reset').on 'click', ->
    $('#new_rma')[0].reset();

  $('#hardwareTypeGrid').kendoGrid
    dataSource: hardwareTypeDataSource
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
        title: 'Hardware Type'
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

  $('#rmaGrid').kendoGrid
    dataSource: rmaDataSource
    height: 450
    sortable: true
    filterable: mode: 'row'
    pageable:
      refresh: true
      pageSizes: true
      buttonCount: 5
    columns: [
      {
        field: 'rma_number'
        title: 'RMA #'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'serial_number'
        title: 'Serial #'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'reference_number'
        title: 'Reference #'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'tracking_number'
        title: 'Tracking #'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'comments'
        title: 'Comments'
        filterable: cell: operator: 'contains'
      }
      {
        field: 'hardware_type_name'
        title: 'Hardware Type'
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
    ]
  return



# Form Validations
judgeValidateForm $('#new_rma')