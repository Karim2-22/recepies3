const CACHE_NAME = 'recipes-cache-v1';
const urlsToCache = [
  '/',
  '/index.html',
  '/recipes.html',
  '/about.html',
  '/contact.html',
  '/css/styles.css',
  '/js/app.js',
  '/images/pasta.jpg',
  '/images/salad.jpg',
  '/images/soup.jpg'
];

self.addEventListener('install', (event) => {
  event.waitUntil(
    caches.open(CACHE_NAME)
      .then((cache) => cache.addAll(urlsToCache))
  );
});

self.addEventListener('fetch', (event) => {
  event.respondWith(
    caches.match(event.request)
      .then((response) => response || fetch(event.request))
  );
});