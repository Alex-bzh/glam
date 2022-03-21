// pathname eg: /home
const path = $(location).attr('pathname').substr(1);

// menu: active tab
$('.nav-link').each(function() {
	// except in language menu
	if ($(this).attr('id') != 'fr' && $(this).attr('id') != 'en') {
		if (path != '') {
			if (path == $(this).attr('id')) {
				$(this).addClass('active');
				$(this).attr('aria-current', 'page');
			}
		} else {
			$('#home').addClass('active');
			$('#home').attr('aria-current', 'page');
		}
	}
});

// add fields for another author
function addAuthor() {
	const n = parseInt($('#nAuthors').val()) + 1;
	$('#nAuthors').val(n);

	$('#authors').append('\
		<div class="row mb-3" id="author_' + n + '">\
			<input type="hidden" id="ref_role" name="ref_roles" value="1" />\
			<label class="col-sm-2 col-form-label" for="firstname_' + n + '"></label>\
			<div class="col-sm-5">\
				<input class="form-control" type="text" id="firstname_' + n + '" name="firstnames" aria-label="firstname" required="required"/>\
			</div>\
			<div class="col-sm-5">\
				<div class="input-group">\
					<input class="form-control" type="text" id="lastname_' + n + '" name="lastnames" aria-label="lastname" required= "required"/>\
					<button class="btn btn-outline-secondary" type="button" id="delete-author_' + n + '" onclick="deleteAuthor()">\
						<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person-dash-fill" viewBox="0 0 16 16">\
							<path fill-rule="evenodd" d="M11 7.5a.5.5 0 0 1 .5-.5h4a.5.5 0 0 1 0 1h-4a.5.5 0 0 1-.5-.5z"/>\
							<path d="M1 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H1zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>\
						</svg>\
					</button>\
				</div>\
			</div>\
		</div>');
}

// delete an author
function deleteAuthor() {
	const n = parseInt($('#nAuthors').val())
	$('#author_' + n).remove();
	$('#nAuthors').val(n - 1);
}

// online doc
$('#online').click( function() {
	if ($(this).is(":checked")) {
		// no numbering
		$('#numbering').addClass('d-none');
		$('#pages_from').removeAttr('required');
		$('#pages_to').removeAttr('required');
		// url required
		$('#link').removeClass('d-none');
		$('#url').attr('required', 'required');
	} else {
		// numbering required
		$('#numbering').removeClass('d-none');
		$('#pages_from').attr('required', 'required');
		$('#pages_to').attr('required', 'required');
		// url optional
		$('#link').addClass('d-none');
		$('#url').removeAttr('required');
	}
});
