// /assets/js/audio-player.js

document.addEventListener('DOMContentLoaded', () => {
    console.log("Audio Player script started.");

    const players = document.querySelectorAll('.custom-audio-player');
    if (players.length === 0) {
        console.log("No audio players found on this page.");
        return;
    }

    players.forEach((player, index) => {
        console.log(`Initializing player ${index + 1}`);

        const audio = player.querySelector('.audio-element');
        const playPauseBtn = player.querySelector('.play-pause-btn');
        const playIcon = player.querySelector('.play-icon');
        const pauseIcon = player.querySelector('.pause-icon');
        const progressBar = player.querySelector('.progress-bar');
        const progress = player.querySelector('.progress');
        const currentTimeEl = player.querySelector('.current-time');
        const totalTimeEl = player.querySelector('.total-time');

        if (!audio || !playPauseBtn) return;

        // --- HELPER FUNCTION TO FORMAT TIME ---
        function formatTime(seconds) {
            if (isNaN(seconds)) return "0:00";
            const minutes = Math.floor(seconds / 60);
            const secs = Math.floor(seconds % 60);
            return `${minutes}:${secs < 10 ? '0' : ''}${secs}`;
        }

        // --- PLAY & PAUSE LOGIC ---
        function togglePlayPause() {
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

            if (duration) {
                audio.currentTime = (clickPositionX / width) * duration;
            }
        });
    });
});