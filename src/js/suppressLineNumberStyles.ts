// Stop it injecting styles into the head
const head = document.head;
const nativeAppendChild = head.appendChild;
head.appendChild = function <T extends Node>(node: T): T {
    return node instanceof HTMLStyleElement ? node : (nativeAppendChild.call(this, node) as T);
};
Promise.resolve().then(() => {
    delete (head as { appendChild?: unknown }).appendChild;
});

export {};
