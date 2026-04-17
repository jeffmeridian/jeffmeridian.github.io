// /assets/js/video-player.js
(function() {
  window.initVideoPlayer = function(id) {
    console.log("Initializing video player:", id);
    const root = document.getElementById(id);
    if (!root) {
      console.error("Video player root not found:", id);
      return;
    }

    const video = root.querySelector('video');
    const wrapper = root.querySelector('.video-main-wrapper');
    const overlay = root.querySelector('.play-overlay');
    const playIc = root.querySelector('.play-ic');
    const pauseIc = root.querySelector('.pause-ic');
    const bar = root.querySelector('.progress-bar');
    const wrap = root.querySelector('.progress-wrap');
    const currTimeEl = root.querySelector('.curr');
    const totalTimeEl = root.querySelector('.total');
    const muteBtn = root.querySelector('.mute-toggle');
    const fsBtn = root.querySelector('.full-toggle');
    const controlsBar = root.querySelector('.controls-bar');

    const fmt = s => {
      const m = Math.floor(s / 60);
      const sec = Math.floor(s % 60).toString().padStart(2, '0');
      return m + ":" + sec;
    };

    const toggle = (e) => {
      if (e) e.preventDefault();
      if (video.paused) {
        video.play().catch(err => console.error("Play failed:", err));
      } else {
        video.pause();
      }
    };

    if (wrapper) wrapper.addEventListener('click', toggle);
    if (overlay) overlay.addEventListener('click', (e) => { e.stopPropagation(); toggle(e); });

    video.addEventListener('play', () => {
      if (playIc) playIc.style.display = 'none';
      if (pauseIc) pauseIc.style.display = 'block';
      if (overlay) {
        overlay.style.opacity = '0';
        overlay.style.pointerEvents = 'none';
      }
    });

    video.addEventListener('pause', () => {
      if (playIc) playIc.style.display = 'block';
      if (pauseIc) pauseIc.style.display = 'none';
      if (overlay) {
        overlay.style.opacity = '1';
        overlay.style.pointerEvents = 'auto';
      }
      if (controlsBar) controlsBar.style.opacity = '1';
    });

    video.addEventListener('timeupdate', () => {
      if (!video.duration) return;
      const p = (video.currentTime / video.duration) * 100;
      if (bar) bar.style.width = p + '%';
      if (currTimeEl) currTimeEl.textContent = fmt(video.currentTime);
    });

    video.addEventListener('loadedmetadata', () => {
      if (totalTimeEl) totalTimeEl.textContent = fmt(video.duration);
    });

    if (wrap) {
      wrap.addEventListener('click', (e) => {
        e.stopPropagation();
        if (!video.duration) return;
        const rect = wrap.getBoundingClientRect();
        const pos = (e.clientX - rect.left) / rect.width;
        video.currentTime = pos * video.duration;
      });
    }

    if (muteBtn) {
      muteBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        video.muted = !video.muted;
        const on = muteBtn.querySelector('.vol-on');
        const off = muteBtn.querySelector('.vol-off');
        if (on) on.style.display = video.muted ? 'none' : 'block';
        if (off) off.style.display = video.muted ? 'block' : 'none';
      });
    }

    if (fsBtn) {
      fsBtn.addEventListener('click', (e) => {
        e.stopPropagation();
        if (video.requestFullscreen) video.requestFullscreen();
        else if (video.webkitRequestFullscreen) video.webkitRequestFullscreen();
      });
    }

    let hideTimeout;
    const showControls = () => {
      if (controlsBar) {
        controlsBar.style.opacity = '1';
        controlsBar.style.transform = 'translateY(0)';
      }
      root.style.cursor = 'default';
      clearTimeout(hideTimeout);
      if (!video.paused) {
        hideTimeout = setTimeout(() => {
          if (controlsBar) {
            controlsBar.style.opacity = '0';
            controlsBar.style.transform = 'translateY(10px)';
          }
          root.style.cursor = 'none';
        }, 2500);
      }
    };

    root.addEventListener('mousemove', showControls);
    video.addEventListener('play', showControls);
    
    // In case metadata is already loaded
    if (video.readyState >= 1) {
       if (totalTimeEl) totalTimeEl.textContent = fmt(video.duration);
    }
  };
})();
