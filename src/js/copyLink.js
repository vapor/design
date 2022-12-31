export function copyURLToClipboard() {
    navigator.clipboard.writeText(window.location.href);
}