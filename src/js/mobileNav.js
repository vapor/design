// Mobile off-canvas navigation panel.
//
// Replaces the old Bootstrap collapse menu (SiteNavigation): below `lg` the nav
// slides in from the right as a panel. Opened by the hamburger, closed by the X,
// the backdrop, Escape, or after tapping a real navigation link. No-ops on sites
// that don't render the panel markup yet (rollout window).
(function () {
    "use strict";

    var toggle = document.getElementById("vapor-navmenu-toggle");
    var panel = document.getElementById("vapor-navmenu");
    if (!toggle || !panel) return;

    var closeBtn = document.getElementById("vapor-navmenu-close");
    var backdrop = document.getElementById("vapor-nav-backdrop");

    function setOpen(open) {
        panel.classList.toggle("vapor-navmenu-open", open);
        if (backdrop) backdrop.classList.toggle("vapor-nav-open", open);
        toggle.setAttribute("aria-expanded", open ? "true" : "false");
    }
    function close() { setOpen(false); }

    toggle.addEventListener("click", function () {
        setOpen(!panel.classList.contains("vapor-navmenu-open"));
    });
    if (closeBtn) closeBtn.addEventListener("click", close);
    if (backdrop) backdrop.addEventListener("click", close);
    document.addEventListener("keydown", function (e) {
        if (e.key === "Escape") close();
    });

    // Close after following a real link, but not when toggling an in-panel
    // dropdown (Documentation / Theme), which use href="#" + data-bs-toggle.
    panel.addEventListener("click", function (e) {
        var link = e.target.closest("a.nav-link[href]");
        if (link && link.getAttribute("href") !== "#" && !link.hasAttribute("data-bs-toggle")) {
            close();
        }
    });
})();
