// Light / Dark / System theme picker.
//
// Replaces the legacy single #theme-switch toggle (toggleDarkMode.js) with a
// dropdown offering an explicit choice. It shares the same model the rest of the
// design system already uses (detectColorScheme.js applies the theme pre-paint
// in the <head>):
//   - "light" / "dark" → stored under the localStorage "theme" key
//   - "system"         → no key stored, so we follow the OS (prefers-color-scheme)
//
// Backwards compatibility: this is a no-op on pages that don't render the picker
// markup (i.e. sites still serving the old toggle during the rollout window), so
// main.js can safely import both this and toggleDarkMode.js.
(function () {
    "use strict";

    var items = document.querySelectorAll('.theme-picker .dropdown-item[data-theme]');
    if (!items.length) return; // legacy #theme-switch toggle still in use — leave it to toggleDarkMode.js

    var KEY = "theme";
    var mq = window.matchMedia("(prefers-color-scheme: dark)");

    function stored() {
        try { return localStorage.getItem(KEY); } catch (e) { return null; }
    }
    function current() { return stored() || "system"; }

    function apply(pref) {
        var dark = pref === "dark" || ((pref === "system" || !pref) && mq.matches);
        document.documentElement.classList.toggle("dark", dark);
        var meta = document.querySelector('meta[name="theme-color"]');
        if (meta) meta.setAttribute("content", dark ? "#141416" : "#ffffff");
    }

    function refresh() {
        var c = current();
        var label = c.charAt(0).toUpperCase() + c.slice(1);
        document.querySelectorAll(".theme-name").forEach(function (el) { el.textContent = label; });
        items.forEach(function (a) {
            a.classList.toggle("active", a.getAttribute("data-theme") === c);
        });
        // Mirror the active option's icon onto the toggle so it reflects the
        // current choice (sun / moon / monitor) at a glance.
        var opt = document.querySelector('.theme-picker .dropdown-item[data-theme="' + c + '"] .theme-opt-icon');
        if (opt) {
            document.querySelectorAll(".theme-toggle-icon").forEach(function (el) {
                el.innerHTML = opt.innerHTML;
            });
        }
    }

    function setTheme(pref) {
        try {
            if (pref === "system") localStorage.removeItem(KEY);
            else localStorage.setItem(KEY, pref);
        } catch (e) {}
        apply(pref);
        refresh();
    }

    items.forEach(function (a) {
        a.addEventListener("click", function (e) {
            e.preventDefault();
            setTheme(a.getAttribute("data-theme"));
        });
    });

    // Follow live OS changes only while in system mode.
    mq.addEventListener("change", function () {
        if (current() === "system") apply("system");
    });

    refresh();
})();
