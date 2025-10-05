// /assets/js/audio-player.js

document.addEventListener('DOMContentLoaded', () => {
    // --- DEBUG 1: Does the script start? ---
    console.log("Audio Player script started.");

    const player = document.querySelector('.custom-audio-player');
    if (!player) {
        // --- DEBUG 2: Can the script find the player? ---
        console.error("Could not find the .custom-audio-player element!");
        return; 
    }
    
    // --- DEBUG 3: If it finds the player, log it. ---
    console.log("Successfully found player element:", player);

    const audio = player.querySelector('#audio-element');
    const playPauseBtn = player.querySelector('.play-pause-btn');
    const playIcon = player.querySelector('.play-icon');
    const pauseIcon = player.querySelector('.pause-icon');
    const progressBar = player.querySelector('.progress-bar');
    const progress = player.querySelector('.progress');
    const currentTimeEl = player.querySelector('.current-time');
    const totalTimeEl = player.querySelector('.total-time');

    // --- HELPER FUNCTION TO FORMAT TIME ---
    function formatTime(seconds) {
        const minutes = Math.floor(seconds / 60);
        const secs = Math.floor(seconds % 60);
        return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
    }

    // --- PLAY & PAUSE LOGIC ---
    function togglePlayPause() {
        // --- DEBUG 4: Does the click event work? ---
        console.log("Play/Pause button clicked. Audio is currently:", audio.paused ? "Paused" : "Playing");

        if (audio.paused) {
            audio.play();
            playIcon.style.display = 'none';
            pauseIcon.style.display = 'block';
        } else {
            audio.pause();
            playIcon.style.display = 'block';
            pauseIcon.style.display = 'none';
        }
    }

    playPauseBtn.addEventListener('click', togglePlayPause);

    // --- PROGRESS BAR & TIME UPDATE ---
    audio.addEventListener('timeupdate', () => {
        const percentage = (audio.currentTime / audio.duration) * 100;
        progress.style.width = `${percentage}%`;
        currentTimeEl.textContent = formatTime(audio.currentTime);
    });

    // --- SET TOTAL TIME WHEN AUDIO LOADS ---
    audio.addEventListener('loadedmetadata', () => {
        totalTimeEl.textContent = formatTime(audio.duration);
    });

    // --- SEEK FUNCTIONALITY ---
    progressBar.addEventListener('click', (e) => {
        const rect = progressBar.getBoundingClientRect();
        const clickPositionX = e.clientX - rect.left;
        const width = progressBar.clientWidth;
        const duration = audio.duration;

        audio.currentTime = (clickPositionX / width) * duration;
    });
});