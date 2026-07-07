function setTwitterShareLink() {
    const twitterShareLinks = document.querySelectorAll<HTMLAnchorElement>('.twitter-share-button');
    twitterShareLinks.forEach((link) => {
        link.href = `https://twitter.com/intent/tweet?text=${encodeURIComponent(document.title)}&url=${encodeURIComponent(window.location.href)}`;
    });
}

function setRedditShareLink() {
    const redditShareLinks = document.querySelectorAll<HTMLAnchorElement>('.reddit-share-button');
    redditShareLinks.forEach((link) => {
        link.href = `https://www.reddit.com/submit?title=${encodeURIComponent(document.title)}&url=${encodeURIComponent(window.location.href)}`;
    });
}

function setMastodonShareLink() {
    const mastodonShareLinks = document.querySelectorAll<HTMLAnchorElement>('.mastodon-share-button');
    mastodonShareLinks.forEach((link) => {
        link.href = `https://mastodon.social/share?text=${encodeURIComponent(document.title)}&url=${encodeURIComponent(window.location.href)}`;
    });
}

function setBskyShareLink() {
	const bskyShareLinks = document.querySelectorAll<HTMLAnchorElement>('.bsky-share-button');
	bskyShareLinks.forEach((link) => {
		link.href = `https://bsky.app/intent/compose?text=${encodeURIComponent(document.title)}&url=${encodeURIComponent(window.location.href)}`;
	});
}

setTwitterShareLink();
setRedditShareLink();
setMastodonShareLink();
setBskyShareLink();
