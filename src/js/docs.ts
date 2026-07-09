/*
 * Docs-specific interactions. The shared chrome (navbar dropdowns, dark-mode
 * toggle, syntax highlighting) is handled by design.vapor.codes/main.js; this
 * only covers the documentation body: the mobile sidebar drawer and the
 * on-this-page scroll-spy.
 */
(function () {
    "use strict";

    // --- Mobile drawers: left sidebar + right nav menu ------------------
    const sidebar = document.getElementById("kiln-sidebar");
    const sidebarToggle = document.getElementById("kiln-sidebar-toggle");
    const sidebarClose = document.getElementById("kiln-sidebar-close");
    const navmenu = document.getElementById("kiln-navmenu");
    const navmenuToggle = document.getElementById("kiln-navmenu-toggle");
    const navmenuClose = document.getElementById("kiln-navmenu-close");
    const backdrop = document.getElementById("kiln-doc-backdrop");

    function syncBackdrop() {
        const open = (sidebar && sidebar.classList.contains("kiln-open")) ||
            (navmenu && navmenu.classList.contains("kiln-navmenu-open"));
        if (backdrop) backdrop.classList.toggle("kiln-open", !!open);
    }
    function closeSidebar() {
        if (!sidebar) return;
        sidebar.classList.remove("kiln-open");
        if (sidebarToggle) sidebarToggle.setAttribute("aria-expanded", "false");
        syncBackdrop();
    }
    function closeNavmenu() {
        if (!navmenu) return;
        // Collapse any open picker dropdown so it doesn't float over the page as
        // the panel slides away. Removing `.show` keeps Bootstrap in sync (its
        // toggle reads the menu's class), so the next click still opens it.
        navmenu.querySelectorAll(".dropdown-menu.show").forEach(function (m) {
            m.classList.remove("show");
        });
        navmenu.querySelectorAll('[data-bs-toggle="dropdown"][aria-expanded="true"]').forEach(function (t) {
            t.setAttribute("aria-expanded", "false");
        });
        navmenu.classList.remove("kiln-navmenu-overflow", "kiln-navmenu-open");
        if (navmenuToggle) navmenuToggle.setAttribute("aria-expanded", "false");
        syncBackdrop();
    }

    // The language/version/theme picker dropdowns float over the mobile panel
    // (positioned + height-capped by CSS — shared design CSS for language/theme,
    // local CSS for the version picker). Bootstrap doesn't run Popper for navbar
    // dropdowns and the panel is a scroll container, so flip it to overflow:visible
    // while one is open, else it clips the floating menu.
    function inMobilePanel() { return window.matchMedia("(max-width: 991.98px)").matches; }
    function syncPanelOverflow() {
        if (!navmenu) return;
        const open = !!navmenu.querySelector(
            ".language-picker .dropdown-menu.show," +
            ".kiln-version-nav .dropdown-menu.show," +
            ".theme-picker .dropdown-menu.show"
        );
        navmenu.classList.toggle("kiln-navmenu-overflow", open && inMobilePanel());
    }
    document.addEventListener("shown.bs.dropdown", syncPanelOverflow);
    document.addEventListener("hidden.bs.dropdown", syncPanelOverflow);
    function openSidebar() {
        if (!sidebar) return;
        closeNavmenu();
        sidebar.classList.add("kiln-open");
        if (sidebarToggle) sidebarToggle.setAttribute("aria-expanded", "true");
        syncBackdrop();
    }
    function openNavmenu() {
        if (!navmenu) return;
        closeSidebar();
        navmenu.classList.add("kiln-navmenu-open");
        if (navmenuToggle) navmenuToggle.setAttribute("aria-expanded", "true");
        syncBackdrop();
    }
    function closeAll() { closeSidebar(); closeNavmenu(); }

    if (sidebarToggle) sidebarToggle.addEventListener("click", function () {
        if (sidebar && sidebar.classList.contains("kiln-open")) closeSidebar(); else openSidebar();
    });
    if (sidebarClose) sidebarClose.addEventListener("click", closeSidebar);
    if (navmenuToggle) navmenuToggle.addEventListener("click", function () {
        if (navmenu && navmenu.classList.contains("kiln-navmenu-open")) closeNavmenu(); else openNavmenu();
    });
    if (navmenuClose) navmenuClose.addEventListener("click", closeNavmenu);
    if (backdrop) backdrop.addEventListener("click", closeAll);
    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") closeAll();
    });
    // Close the sidebar drawer after following an in-page nav link on mobile.
    if (sidebar) {
        sidebar.addEventListener("click", function (e) {
            const target = e.target as HTMLElement | null;
            const link = target?.closest("a.kiln-nav-link");
            if (link && window.matchMedia("(max-width: 800px)").matches) closeSidebar();
        });
    }

    // --- Sidebar: animate a section's contents in when expanded ----------
    // Native <details> can't transition its own height, and the `toggle` event
    // fires only on user interaction (not for sections rendered open on load),
    // so we restart a short reveal animation on the freshly-opened list.
    document.querySelectorAll<HTMLDetailsElement>("details.kiln-nav-section").forEach(function (section) {
        section.addEventListener("toggle", function () {
            if (!section.open) return;
            const list = section.querySelector<HTMLElement>(":scope > .kiln-nav-list");
            if (!list) return;
            list.classList.remove("kiln-nav-revealing");
            void list.offsetWidth; // reflow so the animation restarts
            list.classList.add("kiln-nav-revealing");
        });
    });

    // --- On-this-page scroll-spy ----------------------------------------
    const tocLinks = Array.from(
        document.querySelectorAll<HTMLAnchorElement>(".kiln-toc a[href^='#']")
    );
    if (tocLinks.length && "IntersectionObserver" in window) {
        const byId: Record<string, HTMLAnchorElement> = {};
        const headings: HTMLElement[] = [];
        tocLinks.forEach(function (link) {
            const id = decodeURIComponent((link.getAttribute("href") || "").slice(1));
            const el = document.getElementById(id);
            if (el) {
                byId[id] = link;
                headings.push(el);
            }
        });

        let current: string | null = null;
        function setActive(id: string) {
            if (current === id) return;
            current = id;
            tocLinks.forEach(function (l) { l.classList.remove("kiln-toc-active"); });
            const link = byId[id];
            if (link) link.classList.add("kiln-toc-active");
        }

        const observer = new IntersectionObserver(function (entries) {
            // Pick the topmost heading currently intersecting the upper viewport.
            const visible = entries
                .filter(function (e) { return e.isIntersecting; })
                .sort(function (a, b) { return a.boundingClientRect.top - b.boundingClientRect.top; });
            const first = visible[0];
            if (first) setActive(first.target.id);
        }, { rootMargin: "0px 0px -70% 0px", threshold: 0 });

        headings.forEach(function (h) { observer.observe(h); });
    }

    // --- Carbon ads (desktop only, where the TOC sidebar is visible) -----
    // This custom theme doesn't load Kiln's bundled theme.js, so the carbon
    // loader it normally provides is reproduced here. CSP allows cdn.carbonads.com.
    const carbon = document.getElementById("kiln-carbon");
    const serve = carbon?.dataset.serve;
    if (carbon && serve && window.innerWidth > 1200) {
        const ad = document.createElement("script");
        ad.async = true;
        ad.type = "text/javascript";
        ad.id = "_carbonads_js";
        ad.src = "//cdn.carbonads.com/carbon.js?serve=" + encodeURIComponent(serve) +
            "&placement=" + encodeURIComponent(carbon.dataset.placement || "");
        carbon.appendChild(ad);
    }
})();
