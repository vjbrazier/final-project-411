// Boardgame Aficionados - Client JS

// Highlight active nav link
document.addEventListener("DOMContentLoaded", () => {
  const links = document.querySelectorAll(".nav-link");
  const path = window.location.pathname;
  links.forEach((link) => {
    const href = link.getAttribute("href");
    if (href === "/" && path === "/") {
      link.style.color = "#fff";
      link.style.background = "rgba(255,255,255,0.06)";
    } else if (href !== "/" && path.startsWith(href)) {
      link.style.color = "#fff";
      link.style.background = "rgba(255,255,255,0.06)";
    }
  });

  // Animate numbers counting up
  document.querySelectorAll(".game-card-count, .mini-val, .podium-card .stat-pill").forEach((el) => {
    const text = el.innerText;
    const num = parseFloat(text);
    if (!isNaN(num) && num > 0 && !text.includes("%") && !text.includes("W") && !text.includes("L")) {
      animateCount(el, num);
    }
  });

  // Animate ratio bars in on scroll
  const bars = document.querySelectorAll(".ratio-bar, .shot-bar-fill, .piece-bar-red, .piece-bar-yellow");
  if ("IntersectionObserver" in window) {
    const io = new IntersectionObserver((entries) => {
      entries.forEach((e) => {
        if (e.isIntersecting) {
          e.target.style.transition = "width 0.8s cubic-bezier(0.16,1,0.3,1)";
        }
      });
    }, { threshold: 0.2 });
    bars.forEach((b) => io.observe(b));
  }
});

function animateCount(el, target) {
  const duration = 800;
  const start = performance.now();
  const isFloat = String(target).includes(".");
  const initial = 0;

  function step(now) {
    const elapsed = now - start;
    const progress = Math.min(elapsed / duration, 1);
    const eased = 1 - Math.pow(1 - progress, 3);
    const current = initial + (target - initial) * eased;
    el.innerText = isFloat ? current.toFixed(2) : Math.round(current);
    if (progress < 1) requestAnimationFrame(step);
  }
  requestAnimationFrame(step);
}
