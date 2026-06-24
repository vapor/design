export function copyURLToClipboard() {
    navigator.clipboard.writeText(window.location.href);
}

// Wire copy-link buttons via addEventListener (no inline `onclick`, so this works
// under a strict Content-Security-Policy that disallows inline scripts). main.js
// is loaded at the end of <body>, so the buttons already exist here.
document.querySelectorAll('.copy-link-button').forEach((button) => {
    button.addEventListener('click', () => copyURLToClipboard());
});
