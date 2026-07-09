(function () {
    "use strict";

    const BELOW_LG = "(max-width: 991.98px)";
    const PICKER = ".language-picker, .theme-picker";
    const GAP = 12;
    const VISIBLE_ROWS = 3.5;
    const MIN_ROWS_BELOW = 2;

    function menuFor(toggle: Element | null): HTMLElement | null {
        const li = toggle ? toggle.closest(PICKER) : null;
        return li ? li.querySelector<HTMLElement>(".dropdown-menu") : null;
    }

    function rowHeight(menu: HTMLElement): number {
        const item = menu.querySelector(".dropdown-item");
        return item ? item.getBoundingClientRect().height : 40;
    }

    function place(toggle: Element | null, menu: HTMLElement | null) {
        if (!menu || !toggle || !window.matchMedia(BELOW_LG).matches) return;

        menu.style.maxHeight = "";
        menu.classList.remove("picker-dropup");

        const pill = toggle.getBoundingClientRect();
        const spaceBelow = window.innerHeight - pill.bottom - GAP;
        const spaceAbove = pill.top - GAP;

        const row = rowHeight(menu);
        const padTop = parseFloat(getComputedStyle(menu).paddingTop) || 0;
        // Show half a row to hint there's more content
        const cap = Math.round(padTop + row * VISIBLE_ROWS);
        const minBelow = padTop + row * MIN_ROWS_BELOW;

        const flipUp = spaceBelow < minBelow && spaceAbove > spaceBelow;
        const room = flipUp ? spaceAbove : spaceBelow;

        menu.classList.toggle("picker-dropup", flipUp);
        menu.style.maxHeight = Math.max(0, Math.min(cap, room)) + "px";
        menu.style.overflowY = "auto";
    }

    function clear(menu: HTMLElement | null) {
        if (menu) {
            menu.style.maxHeight = "";
            menu.style.overflowY = "";
            menu.classList.remove("picker-dropup");
        }
    }

    document.addEventListener("shown.bs.dropdown", function (e) {
        const toggle = e.target;
        const menu = menuFor(toggle);
        if (!menu) return;
        place(toggle, menu);
        requestAnimationFrame(function () {
            requestAnimationFrame(function () { place(toggle, menu); });
        });
    });
    document.addEventListener("hidden.bs.dropdown", function (e) { clear(menuFor(e.target)); });
})();
