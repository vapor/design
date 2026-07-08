interface ShareTarget {
    selector: string;
    url(title: string, href: string): string;
}

const SHARE_TARGETS: ShareTarget[] = [
    {
        selector: '.twitter-share-button',
        url: (title, href) => `https://twitter.com/intent/tweet?text=${encodeURIComponent(title)}&url=${encodeURIComponent(href)}`,
    },
    {
        selector: '.reddit-share-button',
        url: (title, href) => `https://www.reddit.com/submit?title=${encodeURIComponent(title)}&url=${encodeURIComponent(href)}`,
    },
    {
        selector: '.mastodon-share-button',
        url: (title, href) => `https://mastodon.social/share?text=${encodeURIComponent(title)}&url=${encodeURIComponent(href)}`,
    },
    {
        selector: '.bsky-share-button',
        url: (title, href) => `https://bsky.app/intent/compose?text=${encodeURIComponent(title)}&url=${encodeURIComponent(href)}`,
    },
];

for (const { selector, url } of SHARE_TARGETS) {
    document.querySelectorAll<HTMLAnchorElement>(selector).forEach((link) => {
        link.href = url(document.title, window.location.href);
    });
}
