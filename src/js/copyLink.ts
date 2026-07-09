export function copyURLToClipboard() {
    navigator.clipboard.writeText(window.location.href);
}

document.querySelectorAll('.copy-link-button').forEach((button) => {
    button.addEventListener('click', () => copyURLToClipboard());
});
