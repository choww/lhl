$(document).ready(function() {

	/*** INGREDIENT CHECKLIST ***/
	$('.ingredient-list li').append("<span class='ingredient-checkbox'></span>");
	$('.ingredient-list li').click(function() {
		$(this).toggleClass('checked');
		$(this).find('.ingredient-checkbox').fadeToggle('fast');
	});

	/*** TOGGLE RECIPE INSTRUCTION PHOTOS ***/
	$('.toggle-pics').click(function(e) {
		e.preventDefault();
		$('#l-instructions img').toggle();
	})

	/*** RECIPE BOOKMARK ***/
	var bookmark = "<span class='bookmark'>Bookmark?</span>";
	var bookmarked = "<span class='bookmarked'><a name='bookmarked'>Bookmarked</a></span>";
	var link = "<a href='#bookmarked'>Go to bookmark</a>";
	var info = "Keep your place in the instructions by clicking on the text!";
	$instruction = $('#l-instructions em');

	function stickyBookmark() {
		$instruction.html(link);
		$instruction.addClass("sticky-bookmark-nav")
	};

	function removeSticky() {
		$instruction.html(info);
		$instruction.removeClass("sticky-bookmark-nav");
	}


	$('#l-instructions li')
		.mouseenter(function() {
			$getBookmarked = $(this).find('.bookmarked');
			// only see 'bookmark' prompt if the instruction isn't bookmarked
			if ( !$getBookmarked.length ) {
				$(this).prepend(bookmark);
			};
		})
		.on('click', function() {
			// toggle bookmark badge
			if ( $('.bookmarked').length ) {
				$getBookmarked.remove();
			}
			else {
				$(this).find('.bookmark').replaceWith(bookmarked);
				$('#l-instructions em').html(link);
			};

			$('.bookmarked').length ? stickyBookmark() : removeSticky();
		})
		.mouseleave(function() {
			$('.bookmark').remove();
	});

	$('#l-instructions em').click(function() {
		$('html, body').animate({ scrollTop: $('.bookmarked').offset().top }, 800);
	});


});