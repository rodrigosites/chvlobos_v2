$(document).on('turbolinks:load', function(){
	$('#salario_valor').mask('099,00');
  $('#salario_data_inicio').mask('00/00/0000');
  $('#salario_data_fim').mask('00/00/0000');
});