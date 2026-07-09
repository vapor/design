(function () {
    "use strict";

    const banner = document.querySelector<HTMLElement>(".vapor-announce");
    if (!banner) return;

    const id = banner.getAttribute("data-announce-id") || "default";
    const key = "vapor-announce:dismissed:" + id;

    try {
        if (window.localStorage.getItem(key) === "1") {
            banner.style.transition = "none";
            banner.classList.add("is-dismissed");
            requestAnimationFrame(() => (banner.style.transition = ""));
        }
    } catch (_e) {}

    const close = banner.querySelector<HTMLButtonElement>(".vapor-announce__close");
    close?.addEventListener("click", function () {
        banner.classList.add("is-dismissed");
        try {
            window.localStorage.setItem(key, "1");
        } catch (_e) {}
    });
})();
