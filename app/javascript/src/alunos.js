$(document).on('turbolinks:load', function(){

  // Máscaras dos campos, utilizando plugin JQuery Masks
  $('#aluno_rg').mask('ZZ.ZZZ.ZZZ.ZZZ.ZZZ-Z', {reverse: true, translation: {Z: {pattern: /[A-Za-z0-9]/}}});
  $('#aluno_cpf').mask('000.000.000-00', {reverse: true});
  $('#aluno_telefone').mask('(00) 0000-0000');
  $('#aluno_celular').mask('(00) 00000-0000');
  $('#aluno_cep').mask('00000-000');
  $('#aluno_uf').mask('AA');
  $('#aluno_nascimento').mask('00/00/0000');

  // Monitora o checkbox e requisita via Ajax os dados do cliente selecionado no select
  $('#aluno_cliente').click(function () {
    if ($('#aluno_cliente').prop('checked')) {
      $.ajax({
        type: "GET",
        url: "/aluno/busca_dados_cliente",
        dataType: "script",
        data: { cliente_id: $('#aluno_cliente_id option:selected').val() }
      });
    } else {
      $('#aluno_nome').val('');
      $('#aluno_rg').val('');
      $('#aluno_cpf').val('');
      $('#aluno_celular').val('');
      $('#aluno_cep').val('');
      $('#aluno_nascimento').val('');
      $('#aluno_nacionalidade').val('');
      $('#aluno_pai').val('');
      $('#aluno_mae').val('');
    }
  });

});