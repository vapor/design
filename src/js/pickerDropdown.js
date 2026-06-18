// Mobile picker-dropdown height cap.
//
// Below `lg`, the language/theme picker dropdowns float over the off-canvas nav
// panel (position:absolute, anchored under their pill). A long list — e.g. the
// docs site's ~10 languages — would otherwise run off the bottom of the screen
// with no way to reach the lower options. Here we cap each dropdown's height to
// the space left below its pill so it never reaches the screen edge, and let it
// scroll instead.
//
// Keyed off the shared `.language-picker`/`.theme-picker` classes (not the panel
// container), so it works in both the shared `.vapor-navmenu` and the docs'
// `.kiln-navmenu`. The Documentation dropdown is excluded — it expands inline and
// the panel itself scrolls. On desktop Bootstrap's own positioning applies.
(function () {
    "use strict";

    var BELOW_LG = "(max-width: 991.98px)";
    var PICKER = ".language-picker, .theme-picker";
    var GAP = 12; // breathing room above the bottom edge

    function menuFor(toggle) {
        var li = toggle && toggle.closest && toggle.closest(PICKER);
        return li ? li.querySelector(".dropdown-menu") : null;
    }

    function cap(menu) {
        if (!menu || !window.matchMedia(BELOW_LG).matches) return;
        menu.style.maxHeight = ""; // reset so we measure the natural top
        var top = menu.getBoundingClientRect().top;
        menu.style.maxHeight = Math.max(0, window.innerHeight - top - GAP) + "px";
        menu.style.overflowY = "auto";
    }

    function clear(menu) {
        if (menu) {
            menu.style.maxHeight = "";
            menu.style.overflowY = "";
        }
    }

    document.addEventListener("shown.bs.dropdown", function (e) { cap(menuFor(e.target)); });
    document.addEventListener("hidden.bs.dropdown", function (e) { clear(menuFor(e.target)); });
})();
