//= require assets/global/plugins/jquery.min.js
//= require assets/global/plugins/jquery-migrate.min
//= require assets/global/plugins/jquery-ui/jquery-ui-1.10.3.custom.min
//= require assets/global/plugins/jquery.blockui.min
//= require assets/global/plugins/jquery.cokie.min
//= require assets/global/plugins/bootstrap/js/bootstrap.min.js
//= require assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown
//= require assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min
//= require assets/global/plugins/uniform/jquery.uniform.min
//= require assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min
//= require assets/global/plugins/jquery-validation/js/jquery.validate.min
//= require assets/global/plugins/select2/select2.min
//= require assets/global/plugins/bootstrap-datepicker/js/bootstrap-datepicker
//= require assets/global/plugins/bootstrap-timepicker/js/bootstrap-timepicker.min
//= require assets/global/plugins/clockface/js/clockface
//= require assets/global/plugins/bootstrap-daterangepicker/moment.min
//= require assets/global/plugins/bootstrap-daterangepicker/daterangepicker
//= require assets/global/plugins/bootstrap-colorpicker/js/bootstrap-colorpicker
//= require assets/global/plugins/bootstrap-datetimepicker/js/bootstrap-datetimepicker.min
//= require assets/global/scripts/metronic
//= require assets/admin/layout/scripts/layout
//= require assets/admin/layout/scripts/quick-sidebar
//= require assets/admin/layout/scripts/demo
//= require assets/admin/pages/scripts/table-advanced
//= require assets/admin/pages/scripts/form-validation
//= require assets/admin/pages/scripts/components-pickers
//= require assets/admin/pages/scripts/login
var initialize = function() {    
	Metronic.init(); // init metronic core components
	Layout.init(); // init current layout
	Login.init();
	Demo.init();
};

$(document).ready(initialize);
$(document).on("page:load", initialize);