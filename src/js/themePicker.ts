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

    type Theme = "light" | "dark" | "system";

    const items = document.querySelectorAll<HTMLElement>('.theme-picker .dropdown-item[data-theme]');
    if (!items.length) return; // legacy #theme-switch toggle still in use — leave it to toggleDarkMode.js

    const KEY = "theme";
    const mq = window.matchMedia("(prefers-color-scheme: dark)");

    // Normalise any stored/attribute value to a known Theme. Only "light"/"dark"
    // are ever persisted (system removes the key), so anything else means system.
    function asTheme(value: string | null): Theme {
        return value === "light" || value === "dark" ? value : "system";
    }

    function stored(): string | null {
        try { return localStorage.getItem(KEY); } catch (e) { return null; }
    }
    function current(): Theme { return asTheme(stored()); }

    function apply(pref: Theme) {
        const dark = pref === "dark" || (pref === "system" && mq.matches);
        document.documentElement.classList.toggle("dark", dark);
        const meta = document.querySelector('meta[name="theme-color"]');
        if (meta) meta.setAttribute("content", dark ? "#141416" : "#ffffff");
    }

    function refresh() {
        const c = current();
        const label = c.charAt(0).toUpperCase() + c.slice(1);
        document.querySelectorAll(".theme-name").forEach(function (el) { el.textContent = label; });
        items.forEach(function (a) {
            a.classList.toggle("active", a.getAttribute("data-theme") === c);
        });
        // Mirror the active option's icon onto the toggle so it reflects the
        // current choice (sun / moon / monitor) at a glance.
        const opt = document.querySelector('.theme-picker .dropdown-item[data-theme="' + c + '"] .theme-opt-icon');
        if (opt) {
            document.querySelectorAll(".theme-toggle-icon").forEach(function (el) {
                el.innerHTML = opt.innerHTML;
            });
        }
    }

    function setTheme(pref: Theme) {
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
            setTheme(asTheme(a.getAttribute("data-theme")));
        });
    });

    // Follow live OS changes only while in system mode.
    mq.addEventListener("change", function () {
        if (current() === "system") apply("system");
    });

    refresh();
})();
