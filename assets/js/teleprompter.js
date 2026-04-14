// File: assets/js/teleprompter.js

document.addEventListener('DOMContentLoaded', () => {
    const slowerButton = document.getElementById('teleprompter-slower');
    const fasterButton = document.getElementById('teleprompter-faster');
  
    // Define the speed levels. 0 is stopped, followed by 5 active speeds.
    const speedLevels = [0, 0.4, 0.8, 1.2, 1.6, 2.0];
    let currentSpeedIndex = 0;
    let scrollInterval = null;
    let accumulatedScroll = 0;
  
    // This is the main function that handles the scrolling animation
    function startScrolling() {
      // Stop any existing scroll interval before starting a new one
      if (scrollInterval) {
        clearInterval(scrollInterval);
      }
  
      // If the speed is 0, we don't need to do anything else. Scrolling is stopped.
      const currentSpeed = speedLevels[currentSpeedIndex];
      if (currentSpeed === 0) {
        document.documentElement.style.scrollBehavior = ''; // Restore CSS smooth scrolling
        return;
      }
      
      accumulatedScroll = 0; // Reset the fractional accumulator
  
      // Disable CSS smooth scrolling so our programmatic pixel-by-pixel animation isn't blocked by Safari!
      document.documentElement.style.scrollBehavior = 'auto';
  
      // Start a new interval to scroll the page
      // We run this every ~16ms, which is close to 60 frames per second for smooth animation
      scrollInterval = setInterval(() => {
        accumulatedScroll += currentSpeed;
        
        // Wait until we have accumulated at least 1 pixel before trying to scroll,
        // because some browsers ignore fractional scrollBy amounts!
        if (accumulatedScroll >= 1) {
          const pixelsToScroll = Math.floor(accumulatedScroll);
          window.scrollBy(0, pixelsToScroll);
          accumulatedScroll -= pixelsToScroll;
        }
  
        // Check if we have reached the bottom of the page
        if ((window.innerHeight + Math.ceil(window.scrollY)) >= document.body.offsetHeight - 2) {
          clearInterval(scrollInterval); // Stop scrolling
          currentSpeedIndex = 0; // Reset speed
          document.documentElement.style.scrollBehavior = ''; // Restore CSS behavior
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