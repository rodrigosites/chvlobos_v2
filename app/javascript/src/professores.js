$(document).on('turbolinks:load', function(){
  $('#professor_rg').mask('ZZ.ZZZ.ZZZ.ZZZ.ZZZ-Z', {reverse: true, translation: {Z: {pattern: /[A-Za-z0-9]/}}});
  $('#professor_cpf').mask('000.000.000-00', {reverse: true});
  $('#professor_telefone').mask('(00) 0000-0000');
  $('#professor_celular').mask('(00) 00000-0000');
  $('#professor_cep').mask('00000-000');
  $('#professor_uf').mask('AA');
  $('#professor_nascimento').mask('00/00/0000');
});