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

startButton.addEventListener('click', () => {
    // Request permission for motion sensors on iOS 13+
    if (typeof DeviceMotionEvent.requestPermission === 'function') {
        DeviceMotionEvent.requestPermission()
            .then(permissionState => {
                if (permissionState === 'granted') {
                    startMotionDetection();
                } else {
                    statusDiv.innerHTML = 'Permission to access motion sensors was denied.';
                }
            })
            .catch(console.error);
    } else {
        // For other devices
        startMotionDetection();
    }
});

function startMotionDetection() {
    mainContent.innerHTML = '<h1>Alarm Activated</h1><p>The guard dog is on duty.</p>';
    
    motionHandler = (event) => {
        // Do nothing if a bark is already in progress
        if (isBarking) {
            return;
        }

        const acceleration = event.accelerationIncludingGravity;

        if (lastX !== null) {
            const deltaX = Math.abs(lastX - acceleration.x);
            const deltaY = Math.abs(lastY - acceleration.y);
            const deltaZ = Math.abs(lastZ - acceleration.z);

            if (deltaX > threshold || deltaY > threshold || deltaZ > threshold) {
                isBarking = true; // Set the flag to true
                
                // Select and play a random bark
                const randomIndex = Math.floor(Math.random() * barkSounds.length);
                const randomBark = barkSounds[randomIndex];
                randomBark.play();
                
                // Listen for when the sound finishes
                randomBark.onended = () => {
                    // Wait for a random delay (e.g., 2-5 seconds) before being ready again
                    const randomDelay = Math.random() * 3000 + 2000;
                    setTimeout(() => {
                        isBarking = false; // Reset the flag
                    }, randomDelay);
                };
            }
        }

        lastX = acceleration.x;
        lastY = acceleration.y;
        lastZ = acceleration.z;
    };

    window.addEventListener('devicemotion', motionHandler, true);
}