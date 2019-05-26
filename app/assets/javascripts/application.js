// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery3
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require jquery-ui/widgets/sortable

$(function() {
  return $('.table-sortable').sortable({
    axis: 'y',
    items: '.item',
    update: function(e, ui) {
      var item, item_data, params;
      item = ui.item;
      item_data = item.data();
      params = {
        _method: 'put'
      };
      params[item_data.model_name] = {
        row_order_position: item.index()
      };
      return $.ajax({
        type: 'POST',
        url: item_data.update_url,
        dataType: 'json',
        data: params
      });
    }
  });
});
