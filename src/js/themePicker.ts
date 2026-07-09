(function () {
    "use strict";

    type Theme = "light" | "dark" | "system";

    const items = document.querySelectorAll<HTMLElement>('.theme-picker .dropdown-item[data-theme]');
    if (!items.length) return;

    const KEY = "theme";
    const mq = window.matchMedia("(prefers-color-scheme: dark)");

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

    // Update based on OS preference change in system mode
    mq.addEventListener("change", function () {
        if (current() === "system") apply("system");
    });

    refresh();
})();
