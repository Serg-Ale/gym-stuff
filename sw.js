// Service worker: abre o app sem internet (academia costuma ter sinal ruim).
// Ao mudar qualquer arquivo listado em SHELL, aumente a versão em V.
const V = "gym-v1";
const SHELL = [
  "./",
  "index.html",
  "manifest.webmanifest",
  "icon-192.png",
  "icon-512.png",
  "vendor/supabase.js",
  "fonts/Barlow-400.woff2",
  "fonts/Barlow-500.woff2",
  "fonts/Barlow-600.woff2",
  "fonts/BigShouldersDisplay-700.woff2",
  "img/qua-1.jpg",
  "img/qua-2.jpg",
  "img/qua-3.jpg",
  "img/qua-4.jpg",
  "img/qua-5.jpg",
  "img/qua-6.jpg",
  "img/qui-1.jpg",
  "img/qui-2.jpg",
  "img/qui-3.jpg",
  "img/qui-4.jpg",
  "img/qui-5.jpg",
  "img/qui-6.jpg",
  "img/qui-7.jpg",
  "img/seg-1.jpg",
  "img/seg-2.jpg",
  "img/seg-3.jpg",
  "img/seg-4.jpg",
  "img/seg-5.jpg",
  "img/seg-6.jpg",
  "img/seg-7.jpg",
  "img/sex-1.jpg",
  "img/sex-2.jpg",
  "img/sex-3.jpg",
  "img/sex-4.jpg",
  "img/sex-5.jpg",
  "img/sex-6.jpg",
  "img/ter-1.jpg",
  "img/ter-2.jpg",
  "img/ter-3.jpg",
  "img/ter-4.jpg",
  "img/ter-5.jpg",
  "img/ter-6.jpg",
  "img/ter-7.jpg"
];

self.addEventListener("install", e => {
  e.waitUntil(caches.open(V).then(c => c.addAll(SHELL)).then(() => self.skipWaiting()));
});
self.addEventListener("activate", e => {
  e.waitUntil(caches.keys().then(ks => Promise.all(ks.filter(k => k !== V).map(k => caches.delete(k)))).then(() => self.clients.claim()));
});
self.addEventListener("fetch", e => {
  const req = e.request, url = new URL(req.url);
  // Só arquivos do próprio site; chamadas ao Supabase passam direto.
  if (req.method !== "GET" || url.origin !== location.origin) return;
  const isPage = req.mode === "navigate" || url.pathname === "/" || url.pathname.endsWith("/index.html");
  if (isPage) {
    // Rede primeiro, para receber versões novas; cache se estiver sem sinal.
    e.respondWith(fetch(req).then(r => { const c = r.clone(); caches.open(V).then(ch => ch.put("./", c)); return r; })
      .catch(() => caches.match("./") || caches.match("index.html")));
    return;
  }
  e.respondWith(caches.match(req).then(hit => hit || fetch(req).then(r => { const c = r.clone(); caches.open(V).then(ch => ch.put(req, c)); return r; })));
});
