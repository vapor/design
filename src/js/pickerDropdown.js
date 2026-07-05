// Mobile picker-dropdown placement.
//
// Below `lg`, the language/theme picker dropdowns float over the off-canvas nav
// panel (position:absolute, anchored to their pill). Two things can leave a
// picker with no room to open into:
//
//   1. It sits near the bottom of the screen (a long list — e.g. the docs site's
//      ~10 languages — or simply a short viewport), so opening downward runs off
//      the bottom edge.
//   2. Opening a picker closes whatever other dropdown was open (Bootstrap only
//      keeps one open at a time). On the docs site the tall "Documentation" menu
//      collapses as the picker opens, which reflows the panel and frees space
//      below the pill *after* we first measure it.
//
// So we (a) open the menu upward when there's more room above the pill than
// below, and (b) re-measure once the layout has settled so a menu that opened
// cramped grows to fill the space the collapse just freed. In every case the
// height is capped to the available space and the overflow scrolls, so the list
// never reaches the screen edge. On desktop Bootstrap's own positioning applies.
//
// Keyed off the shared `.language-picker`/`.theme-picker` classes (not the panel
// container), so it works in both the shared `.vapor-navmenu` and the docs'
// `.kiln-navmenu`. The Documentation dropdown is excluded — it expands inline and
// the panel itself scrolls.
(function () {
    "use strict";

    var BELOW_LG = "(max-width: 991.98px)";
    var PICKER = ".language-picker, .theme-picker";
    var GAP = 12; // breathing room from the screen edge

    function menuFor(toggle) {
        var li = toggle && toggle.closest && toggle.closest(PICKER);
        return li ? li.querySelector(".dropdown-menu") : null;
    }

    // Decide whether the open menu should drop down or flip up, and cap its height
    // to the room available in that direction.
    function place(toggle, menu) {
        if (!menu || !toggle || !window.matchMedia(BELOW_LG).matches) return;

        // Reset prior sizing/placement so we measure the natural layout.
        menu.style.maxHeight = "";
        menu.classList.remove("picker-dropup");

        var pill = toggle.getBoundingClientRect();
        var spaceBelow = window.innerHeight - pill.bottom - GAP;
        var spaceAbove = pill.top - GAP;
        var natural = menu.scrollHeight;

        // Flip up only when the list can't fit below AND there's genuinely more
        // room above — otherwise prefer the usual downward drop.
        var flipUp = natural > spaceBelow && spaceAbove > spaceBelow;
        var room = flipUp ? spaceAbove : spaceBelow;

        menu.classList.toggle("picker-dropup", flipUp);
        menu.style.maxHeight = Math.max(0, room) + "px";
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
        // A sibling dropdown closing (e.g. the docs "Documentation" menu) reflows
        // the panel and moves this pill, so re-measure once that has settled.
        requestAnimationFrame(function () {
            requestAnimationFrame(function () { place(toggle, menu); });
        });
    });
    document.addEventListener("hidden.bs.dropdown", function (e) { clear(menuFor(e.target)); });
})();
