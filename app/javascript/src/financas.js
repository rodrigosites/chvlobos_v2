$(document).on('turbolinks:load', function(){

	// Visualiza Folha de Pagamento
	$('#folha_button').click(function () {
		if ($('#folhapagamento_mes option:selected').val().length && $('#folhapagamento_ano option:selected').val().length) {
			$('#loading_gif').show();
			$('#conteudo').html("");
			$.ajax ({
				url: "/visualiza_folha",
				type: "GET",
				dataType: "script",
				data: { mes: $('#folhapagamento_mes option:selected').val(), ano: $('#folhapagamento_ano option:selected').val() },
				success: function(data) {
          $('#loading_gif').hide();
        }
			});
		} else {
			alert("Por favor selecione o mês e o ano para a busca.");
		}
	});

	// Visualiza Boletos por Cliente
	$('#boletos_button').click(function() {
		if ($('#valorboleto_mes option:selected').val().length && $('#valorboleto_ano option:selected').val().length) {
			$('#loading_gif').show();
			$('#conteudo').html("");
			$.ajax ({
			  url: "/visualiza_boletos",
			  type: "GET",
			  dataType: "script",
			  data: { mes: $('#valorboleto_mes option:selected').val(), ano: $('#valorboleto_ano option:selected').val() },
			  success: function(data) {
          $('#loading_gif').hide();
        }
			});
		} else {
			alert("Por favor selecione o mês e o ano para a busca.");
		}
	});

});

// Esconde/mostra linha dos alunos de cada professor (fora do load:turbolinks porque é carregado via ajax após execução)
$(document).on('click', 'button[id^="aula_"]', function() {
	$('table.table-striped tr').filter(".professor" + this.value).toggle();	
});