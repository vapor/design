// Mobile picker-dropdown placement.
//
// Below `lg`, the language/theme picker dropdowns float over the off-canvas nav
// panel (position:absolute, anchored to their pill). A long list (e.g. the
// language picker) would otherwise open as tall as the screen — and if it flips
// upward, run off the top edge. So instead of opening "as many items as fit", we
// cap the menu to a fixed ~3½ rows and scroll the rest. The half row is
// deliberate: it makes it obvious the list continues.
//
// Placement:
//   * Open downward by default, capped to 3½ rows (or the room below, whichever
//     is smaller).
//   * If there isn't even room for ~2 rows below, flip above the pill instead
//     (still capped to 3½ rows / the room above).
//
// We re-measure once the layout settles (double rAF) because opening a picker
// closes any other open dropdown — e.g. the docs "Documentation" menu — which
// reflows the panel and moves the pill.
//
// Keyed off the shared `.language-picker`/`.theme-picker` classes (not the panel
// container), so it works in both the shared `.vapor-navmenu` and the docs'
// `.kiln-navmenu`. On desktop Bootstrap's own positioning applies.
(function () {
    "use strict";

    var BELOW_LG = "(max-width: 991.98px)";
    var PICKER = ".language-picker, .theme-picker";
    var GAP = 12;             // min breathing room from the screen edge
    var VISIBLE_ROWS = 3.5;   // show 3½ options so a longer list visibly continues
    var MIN_ROWS_BELOW = 2;   // flip up when fewer than this fit below the pill

    function menuFor(toggle) {
        var li = toggle && toggle.closest && toggle.closest(PICKER);
        return li ? li.querySelector(".dropdown-menu") : null;
    }

    function rowHeight(menu) {
        var item = menu.querySelector(".dropdown-item");
        return item ? item.getBoundingClientRect().height : 40;
    }

    function place(toggle, menu) {
        if (!menu || !toggle || !window.matchMedia(BELOW_LG).matches) return;

        // Reset prior sizing/placement so we measure natural rows.
        menu.style.maxHeight = "";
        menu.classList.remove("picker-dropup");

        var pill = toggle.getBoundingClientRect();
        var spaceBelow = window.innerHeight - pill.bottom - GAP;
        var spaceAbove = pill.top - GAP;

        var row = rowHeight(menu);
        var padTop = parseFloat(getComputedStyle(menu).paddingTop) || 0;
        // Fixed target height: the menu's top padding + 3½ rows. The half row is
        // clipped by max-height, hinting there's more to scroll to.
        var cap = Math.round(padTop + row * VISIBLE_ROWS);
        var minBelow = padTop + row * MIN_ROWS_BELOW;

        // Prefer down; only flip up when down can't fit a couple of rows and up
        // has more room.
        var flipUp = spaceBelow < minBelow && spaceAbove > spaceBelow;
        var room = flipUp ? spaceAbove : spaceBelow;

        menu.classList.toggle("picker-dropup", flipUp);
        // Never exceed the cap (don't open as tall as possible) nor the room.
        menu.style.maxHeight = Math.max(0, Math.min(cap, room)) + "px";
        menu.style.overflowY = "auto";
    }

    function clear(menu) {
        if (menu) {
            menu.style.maxHeight = "";
            menu.style.overflowY = "";
            menu.classList.remove("picker-dropup");
        }
    }

    document.addEventListener("shown.bs.dropdown", function (e) {
        var toggle = e.target;
        var menu = menuFor(toggle);
        if (!menu) return;
        place(toggle, menu);
        requestAnimationFrame(function () {
            requestAnimationFrame(function () { place(toggle, menu); });
        });
    });
    document.addEventListener("hidden.bs.dropdown", function (e) { clear(menuFor(e.target)); });
})();
