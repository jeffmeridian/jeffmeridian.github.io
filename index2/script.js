const startButton = document.getElementById('startButton');
const statusDiv = document.getElementById('status');
const mainContent = document.getElementById('main-content');
const barkSounds = document.querySelectorAll('.bark-sound');

let motionHandler = null;
let lastX = null;
let lastY = null;
let lastZ = null;
const threshold = 1.0; // Motion sensitivity. Lower is more sensitive.
let isBarking = false; // Flag to prevent rapid re-triggering.

// This is the main entry point when the user clicks the button.
startButton.addEventListener('click', () => {
    // First, handle the iOS-specific permission request for motion sensors.
    if (typeof DeviceMotionEvent.requestPermission === 'function') {
        // This function only exists on iOS 13+
        DeviceMotionEvent.requestPermission()
            .then(permissionState => {
                if (permissionState === 'granted') {
                    // User granted permission.
                    startMotionDetection();
                } else {
                    // User denied permission.
                    statusDiv.innerHTML = 'Permission to access motion sensors was denied.';
                }
            })
            .catch(console.error);
    } else {
        // This block runs on Android, Windows, etc., where no special permission is needed.
        startMotionDetection();
    }
});

function startMotionDetection() {
    // Update the UI to show the alarm is active.
    mainContent.innerHTML = '<h1>Alarm Activated</h1><p>The guard dog is on duty.</p>';

    // --- Audio Unlock Fix ---
    // Mobile browsers require audio to be initiated by a user action (the click).
    // We play and immediately pause each sound to "prime" them for later use.
    // This happens silently and instantly.
    barkSounds.forEach(sound => {
        sound.play();
        sound.pause();
        sound.currentTime = 0; // Rewind the sound to the beginning.
    });

    // --- Motion Detection Logic ---
    motionHandler = (event) => {
        // Do nothing if a bark is already playing or in its cooldown period.
        if (isBarking) {
            return;
        }

        const acceleration = event.accelerationIncludingGravity;

        if (lastX !== null) {
            // Calculate the change in motion since the last check.
            const deltaX = Math.abs(lastX - acceleration.x);
            const deltaY = Math.abs(lastY - acceleration.y);
            const deltaZ = Math.abs(lastZ - acceleration.z);

            // Check if the change in motion exceeds our sensitivity threshold.
            if (deltaX > threshold || deltaY > threshold || deltaZ > threshold) {
                isBarking = true; // Set the flag to true to prevent immediate re-triggering.
                
                // Select and play a random bark.
                const randomIndex = Math.floor(Math.random() * barkSounds.length);
                const randomBark = barkSounds[randomIndex];
                randomBark.play();
                
                // When the current bark sound finishes playing...
                randomBark.onended = () => {
                    // ...wait for a random delay (2-5 seconds) before being ready again.
                    const randomDelay = Math.random() * 3000 + 2000;
                    setTimeout(() => {
                        isBarking = false; // Reset the flag, allowing a new bark on the next motion.
                    }, randomDelay);
                };
            }
        }

        // Store the current acceleration values for the next comparison.
        lastX = acceleration.x;
        lastY = acceleration.y;
        lastZ = acceleration.z;
    };

    // Start listening for the 'devicemotion' event.
    window.addEventListener('devicemotion', motionHandler, true);
}