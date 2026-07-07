// Bootstrap fires custom dropdown lifecycle events (namespaced `.bs.dropdown`)
// on the toggle element and bubbling to document. They aren't in the DOM lib's
// event maps, so declaration-merge them here — then addEventListener is
// type-checked on the event name and the handler's event is typed (no casts).
//
// Bootstrap dispatches them on the element being toggled, so `target` is a
// non-null Element for our handlers.
type BootstrapDropdownEvent = Event & { readonly target: Element };

declare global {
    interface DocumentEventMap {
        'show.bs.dropdown': BootstrapDropdownEvent;
        'shown.bs.dropdown': BootstrapDropdownEvent;
        'hide.bs.dropdown': BootstrapDropdownEvent;
        'hidden.bs.dropdown': BootstrapDropdownEvent;
    }
    interface HTMLElementEventMap {
        'show.bs.dropdown': BootstrapDropdownEvent;
        'shown.bs.dropdown': BootstrapDropdownEvent;
        'hide.bs.dropdown': BootstrapDropdownEvent;
        'hidden.bs.dropdown': BootstrapDropdownEvent;
    }
}

export {};
