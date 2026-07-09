(function () {
    "use strict";

    const STORAGE_KEY = "vaporLangSuggestion";

    interface Locale {
        name: string;
        msg: string;
        go: string;
        no: string;
    }

    const LOCALES = {
        "en":    { name: "English",    msg: "This site is available in English.",            go: "Switch",        no: "No thanks" },
        "de":    { name: "Deutsch",    msg: "Diese Website ist auf Deutsch verfügbar.",       go: "Wechseln",      no: "Nein danke" },
        "es":    { name: "Español",    msg: "Este sitio está disponible en español.",          go: "Cambiar",       no: "No, gracias" },
        "fr":    { name: "Français",   msg: "Ce site est disponible en français.",             go: "Changer",       no: "Non merci" },
        "it":    { name: "Italiano",   msg: "Questo sito è disponibile in italiano.",          go: "Cambia",        no: "No, grazie" },
        "ja":    { name: "日本語",      msg: "このサイトは日本語でご利用いただけます。",          go: "切り替える",     no: "結構です" },
        "ko":    { name: "한국어",      msg: "이 사이트는 한국어로 제공됩니다.",                  go: "전환",          no: "괜찮습니다" },
        "nl":    { name: "Nederlands", msg: "Deze site is beschikbaar in het Nederlands.",     go: "Overschakelen", no: "Nee, bedankt" },
        "pl":    { name: "Polski",     msg: "Ta witryna jest dostępna w języku polskim.",      go: "Przełącz",      no: "Nie, dziękuję" },
        "zh":    { name: "简体中文",    msg: "本网站提供简体中文版本。",                          go: "切换",          no: "不用了" },
        "pt-BR": { name: "Português",  msg: "Este site está disponível em português.",         go: "Mudar",         no: "Não, obrigado" }
    } as const satisfies Record<string, Locale>;

    type LocaleKey = keyof typeof LOCALES;
    function isLocaleKey(key: string): key is LocaleKey {
        return key in LOCALES;
    }

    // Map a browser language tag ("en-GB", "zh-CN", "pt-PT", …) to a locale key
    function toLocaleKey(tag: string): string {
        tag = (tag || "").toLowerCase();
        if (tag.indexOf("pt") === 0) return "pt-BR";
        if (tag.indexOf("zh") === 0) return "zh";
        return tag.split("-")[0] ?? "";
    }

    function read(): string | null { try { return localStorage.getItem(STORAGE_KEY); } catch (e) { return null; } }
    function write(v: string) { try { localStorage.setItem(STORAGE_KEY, v); } catch (e) { /* private mode etc. */ } }

    function toRelative(href: string): string {
        try { const u = new URL(href, location.href); return u.pathname + u.search + u.hash; }
        catch (e) { return href; }
    }

    function run() {
        if (read()) return; // already switched or dismissed — don't ask again

        const current = toLocaleKey(document.documentElement.getAttribute("lang") || "en");

        const alts: Record<string, string> = {};
        for (const link of document.querySelectorAll('link[rel="alternate"][hreflang]')) {
            const hl = link.getAttribute("hreflang");
            const href = link.getAttribute("href");
            if (hl && hl !== "x-default" && href) alts[toLocaleKey(hl)] = href;
        }

        const prefs = navigator.languages || [navigator.language || "en"];
        let target: string | null = null;
        let targetUrl: string | null = null;
        for (const pref of prefs) {
            const key = toLocaleKey(pref);
            if (key === current) break;
            const url = alts[key];
            if (url) { target = key; targetUrl = url; break; }
        }
        if (!target || !targetUrl || !isLocaleKey(target)) return;

        showBanner(target, targetUrl);
    }

    function showBanner(target: LocaleKey, url: string) {
        const copy = LOCALES[target];

        const bar = document.createElement("div");
        bar.className = "vapor-lang-suggest";
        bar.setAttribute("role", "region");
        bar.setAttribute("aria-label", copy.msg);
        bar.setAttribute("aria-live", "polite");
        bar.setAttribute("lang", target);

        const msg = document.createElement("p");
        msg.className = "vapor-lang-suggest-msg";
        msg.textContent = copy.msg;

        const actions = document.createElement("div");
        actions.className = "vapor-lang-suggest-actions";

        const go = document.createElement("a");
        go.className = "btn btn-primary vapor-lang-suggest-go";
        go.href = toRelative(url);
        go.textContent = copy.go;
        go.addEventListener("click", function () { write(target); });

        const no = document.createElement("button");
        no.type = "button";
        no.className = "vapor-lang-suggest-no";
        no.textContent = copy.no;
        no.addEventListener("click", function () { write("dismissed"); hide(bar); });

        actions.appendChild(go);
        actions.appendChild(no);
        bar.appendChild(msg);
        bar.appendChild(actions);
        document.body.appendChild(bar);

        const picker = document.getElementById("language-picker-toggle");
        if (picker) picker.classList.add("lang-suggest-pulse");

        requestAnimationFrame(function () { bar.classList.add("is-visible"); });
    }

    function hide(bar: HTMLElement) {
        bar.classList.remove("is-visible");
        const picker = document.getElementById("language-picker-toggle");
        if (picker) picker.classList.remove("lang-suggest-pulse");
        setTimeout(function () { if (bar.parentNode) bar.parentNode.removeChild(bar); }, 250);
    }

    window.vaporLangSuggest = {
        preview: function (locale?: string) {
            const key = locale || "de";
            if (!isLocaleKey(key)) {
                console.warn("vaporLangSuggest: unknown locale '" + key + "'. Try one of: " + Object.keys(LOCALES).join(", "));
                return;
            }
            const existing = document.querySelector(".vapor-lang-suggest");
            if (existing && existing.parentNode) existing.parentNode.removeChild(existing);
            const link = document.querySelector('link[rel="alternate"][hreflang="' + key + '"]');
            showBanner(key, link ? link.getAttribute("href") || "#" : "#");
        },
        reset: function () {
            try { localStorage.removeItem(STORAGE_KEY); } catch (e) {}
            const bar = document.querySelector(".vapor-lang-suggest");
            if (bar && bar.parentNode) bar.parentNode.removeChild(bar);
            const picker = document.getElementById("language-picker-toggle");
            if (picker) picker.classList.remove("lang-suggest-pulse");
            console.info("vaporLangSuggest: cleared the saved choice — reload to re-run detection.");
        }
    };

    if (document.readyState === "loading") {
        document.addEventListener("DOMContentLoaded", run);
    } else {
        run();
    }
})();
