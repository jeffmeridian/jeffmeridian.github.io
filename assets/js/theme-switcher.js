// File: assets/js/theme-switcher.js

document.addEventListener('DOMContentLoaded', () => {
    const themeToggleButton = document.getElementById('theme-toggle-button');
    const body = document.body;
  
    // Function to apply the theme
    const applyTheme = (theme) => {
      if (theme === 'dark') {
        body.classList.add('dark-mode');
        themeToggleButton.innerHTML = '&#9728;&#65039;'; // Sun icon
      } else {
        body.classList.remove('dark-mode');
        themeToggleButton.innerHTML = '&#127769;'; // Moon icon
      }
    };
    
    // Get the saved theme from localStorage
    const savedTheme = localStorage.getItem('theme') || 'light';
    applyTheme(savedTheme);
  
    // Event listener for the toggle button
    themeToggleButton.addEventListener('click', () => {
      // Check if dark mode is currently enabled
      const isDarkMode = body.classList.contains('dark-mode');
      
      // Set the new theme based on the current state
      const newTheme = isDarkMode ? 'light' : 'dark';
  
      // Apply the new theme and save it to localStorage
      applyTheme(newTheme);
      localStorage.setItem('theme', newTheme);
    });
  });