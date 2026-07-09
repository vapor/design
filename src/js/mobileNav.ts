(function () {
    "use strict";

    const toggle = document.getElementById("vapor-navmenu-toggle");
    const panel = document.getElementById("vapor-navmenu");
    if (!toggle || !panel) return;

    const closeBtn = document.getElementById("vapor-navmenu-close");
    const backdrop = document.getElementById("vapor-nav-backdrop");

    function setOpen(open: boolean) {
        panel!.classList.toggle("vapor-navmenu-open", open);
        if (backdrop) backdrop.classList.toggle("vapor-nav-open", open);
        toggle!.setAttribute("aria-expanded", open ? "true" : "false");
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
    
    panel.addEventListener("click", function (e) {
        const target = e.target as HTMLElement | null;
        const link = target?.closest("a.nav-link[href]");
        if (link && link.getAttribute("href") !== "#" && !link.hasAttribute("data-bs-toggle")) {
            close();
        }
    });
})();
