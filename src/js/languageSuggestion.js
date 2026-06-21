// Language-suggestion banner — shared across the Vapor sites (website + docs).
//
// If the visitor's preferred language (navigator.languages) is available as a
// translation of the current page but isn't the language they're viewing, show a
// small, dismissible toast suggesting the switch and briefly highlight the navbar
// language selector. Their choice — switch or dismiss — is remembered in
// localStorage so we never ask again.
//
// It makes no network requests and injects no inline <script>/<style>, so it
// needs no CSP changes (localStorage is not governed by CSP). It no-ops cleanly
// when a page has no translations, when storage is blocked, or when the language
// markup isn't present, so it's safe to ship on every page of both sites.
(function () {
    "use strict";

    var STORAGE_KEY = "vaporLangSuggestion";

    // Native name + copy, in the TARGET language, for each locale we ship. A
    // German visitor sees the prompt in German.
    var LOCALES = {
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
    };

    // Map a browser language tag ("en-GB", "zh-CN", "pt-PT", …) to a locale key
    // we ship. We only have Simplified Chinese and Brazilian Portuguese, so all
    // Chinese / Portuguese variants fold onto those.
    function toLocaleKey(tag) {
        tag = (tag || "").toLowerCase();
        if (tag.indexOf("pt") === 0) return "pt-BR";
        if (tag.indexOf("zh") === 0) return "zh";
        return tag.split("-")[0];
    }

    function read() { try { return localStorage.getItem(STORAGE_KEY); } catch (e) { return null; } }
    function write(v) { try { localStorage.setItem(STORAGE_KEY, v); } catch (e) { /* private mode etc. */ } }

    function run() {
        if (read()) return; // already switched or dismissed — don't ask again

        var current = toLocaleKey(document.documentElement.getAttribute("lang") || "en");

        // Available translations come from the hreflang alternates both sites emit.
        var alts = {};
        var links = document.querySelectorAll('link[rel="alternate"][hreflang]');
        for (var i = 0; i < links.length; i++) {
            var hl = links[i].getAttribute("hreflang");
            if (hl && hl !== "x-default") alts[toLocaleKey(hl)] = links[i].getAttribute("href");
        }

        // The first preferred language we support that isn't the current one. If
        // the visitor's top preference already matches this page, stay quiet.
        var prefs = navigator.languages || [navigator.language || "en"];
        var target = null;
        for (var j = 0; j < prefs.length; j++) {
            var key = toLocaleKey(prefs[j]);
            if (key === current) break;
            if (alts[key]) { target = key; break; }
        }
        if (!target || !LOCALES[target]) return;

        showBanner(target, alts[target]);
    }

    function showBanner(target, url) {
        var copy = LOCALES[target];

        var bar = document.createElement("div");
        bar.className = "vapor-lang-suggest";
        bar.setAttribute("role", "region");
        bar.setAttribute("aria-label", copy.msg);
        bar.setAttribute("aria-live", "polite");
        bar.setAttribute("lang", target);

        var msg = document.createElement("p");
        msg.className = "vapor-lang-suggest-msg";
        msg.textContent = copy.msg;

        var actions = document.createElement("div");
        actions.className = "vapor-lang-suggest-actions";

        var go = document.createElement("a");
        // Reuse the site's primary button styling.
        go.className = "btn btn-primary vapor-lang-suggest-go";
        go.href = url;
        go.textContent = copy.go;
        // Record the choice before the browser follows the link.
        go.addEventListener("click", function () { write(target); });

        var no = document.createElement("button");
        no.type = "button";
        no.className = "vapor-lang-suggest-no";
        no.textContent = copy.no;
        no.addEventListener("click", function () { write("dismissed"); hide(bar); });

        actions.appendChild(go);
        actions.appendChild(no);
        bar.appendChild(msg);
        bar.appendChild(actions);
        document.body.appendChild(bar);

        // Point the visitor at the navbar language selector — where they can
        // change language any time from now on.
        var picker = document.getElementById("language-picker-toggle");
        if (picker) picker.classList.add("lang-suggest-pulse");

        requestAnimationFrame(function () { bar.classList.add("is-visible"); });
    }

    function hide(bar) {
        bar.classList.remove("is-visible");
        var picker = document.getElementById("language-picker-toggle");
        if (picker) picker.classList.remove("lang-suggest-pulse");
        setTimeout(function () { if (bar.parentNode) bar.parentNode.removeChild(bar); }, 250);
    }

    // Small console helper for manual testing / QA — works on any page, including
    // the single-language design guide (which never triggers the banner on its
    // own). In DevTools: `vaporLangSuggest.preview('de')` to force-show a locale's
    // banner, `vaporLangSuggest.reset()` to clear the "don't ask again" flag.
    window.vaporLangSuggest = {
        preview: function (locale) {
            var key = locale || "de";
            if (!LOCALES[key]) {
                console.warn("vaporLangSuggest: unknown locale '" + key + "'. Try one of: " + Object.keys(LOCALES).join(", "));
                return;
            }
            var existing = document.querySelector(".vapor-lang-suggest");
            if (existing && existing.parentNode) existing.parentNode.removeChild(existing);
            // Use the real alternate URL if the page has one, otherwise a no-op href.
            var link = document.querySelector('link[rel="alternate"][hreflang="' + key + '"]');
            showBanner(key, link ? link.getAttribute("href") : "#");
        },
        reset: function () {
            try { localStorage.removeItem(STORAGE_KEY); } catch (e) {}
            var bar = document.querySelector(".vapor-lang-suggest");
            if (bar && bar.parentNode) bar.parentNode.removeChild(bar);
            var picker = document.getElementById("language-picker-toggle");
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
