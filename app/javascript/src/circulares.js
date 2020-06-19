// Máscaras dos campos, utilizando plugin JQuery Masks
$(document).on('turbolinks:load', function(){
  $('#circular_numero_circular').mask('000/0000');
  $('#circular_data_circular').mask('00/00/0000');
  $('#circular_valor_mensalidade').mask('099,00');
  $('#circular_valor_extra').mask('099,00');
  $('#circular_valor_profissionalizante').mask('099,00');
  $('#circular_taxa_matricula').mask('099,00');
  $('#circular_desconto').mask('099,00');
  $('#circular_salario_aula').mask('099,00');
});