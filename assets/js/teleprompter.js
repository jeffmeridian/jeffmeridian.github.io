// File: assets/js/teleprompter.js

document.addEventListener('DOMContentLoaded', () => {
    const slowerButton = document.getElementById('teleprompter-slower');
    const fasterButton = document.getElementById('teleprompter-faster');
  
    // Define the speed levels. 0 is stopped, followed by 5 active speeds.
    const speedLevels = [0, 0.4, 0.8, 1.2, 1.6, 2.0];
    let currentSpeedIndex = 0;
    let scrollInterval = null;
  
    // This is the main function that handles the scrolling animation
    function startScrolling() {
      // Stop any existing scroll interval before starting a new one
      if (scrollInterval) {
        clearInterval(scrollInterval);
      }
  
      // If the speed is 0, we don't need to do anything else. Scrolling is stopped.
      const currentSpeed = speedLevels[currentSpeedIndex];
      if (currentSpeed === 0) {
        return;
      }
  
      // Start a new interval to scroll the page
      // We run this every ~16ms, which is close to 60 frames per second for smooth animation
      scrollInterval = setInterval(() => {
        window.scrollBy(0, currentSpeed); // Scroll down by the speed amount
  
        // Check if we have reached the bottom of the page
        // (window.innerHeight + window.scrollY) is the position of the bottom of the viewport
        // document.body.offsetHeight is the total height of the page
        if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight - 2) {
          clearInterval(scrollInterval); // Stop scrolling
          currentSpeedIndex = 0; // Reset speed
        }
      }, 16);
    }
  
    // Event listener for the "+" button
    fasterButton.addEventListener('click', () => {
      // Increase speed, but not beyond the maximum level
      if (currentSpeedIndex < speedLevels.length - 1) {
        currentSpeedIndex++;
      }
      startScrolling();
    });
  
    // Event listener for the "-" button
    slowerButton.addEventListener('click', () => {
      // Decrease speed, but not below 0
      if (currentSpeedIndex > 0) {
        currentSpeedIndex--;
      }
      startScrolling();
    });
  });