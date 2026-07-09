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
