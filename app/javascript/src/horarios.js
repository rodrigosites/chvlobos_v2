$(document).on('turbolinks:load', function(){
	
	$('#diferenciado_horario').mask('00:00');
  $('#diferenciado_horario').hide();
 
	$('#diferenciado_check').change(function() {
		if ($('#diferenciado_check').prop('checked')) {
			$("option:selected").prop("selected", false);
			$('#horario_horario').prop("disabled", true );
			$('#horario_horario').hide();
			$('#diferenciado_horario').show();
		} else {
			$('#horario_horario').prop("disabled", false );
			$('#horario_horario').show();
			$('#diferenciado_horario').hide();
		}
	});
	
});