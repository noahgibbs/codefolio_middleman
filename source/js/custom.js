/**
 * Main JS file for Horace behaviours
 */
(function ($) {
	"use strict";

	var $body = $('body');

	$(document).ready(function(){

		// Responsive video embeds
		$('.post-content').fitVids();

		// Scroll to top
		$('#top-button').on('click', function(e) {
			$('html, body').animate({
				'scrollTop': 0
			});
			e.preventDefault();
		});

		// Lightbox - see https://simplelightbox.com/ for options
		var lightbox = new SimpleLightbox("a.lightboxed", { /* options */ })

		$('a.lightboxed').on('error.simplelightbox', function (e) {
			console.log("SimpleLightbox error: ", e);
		});
	});

}(jQuery));
