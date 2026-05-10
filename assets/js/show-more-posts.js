document.addEventListener("DOMContentLoaded", () => {
  /**
   * Initializes "Show More" functionality for a grid and button.
   * @param {string} buttonId - The ID of the "Show More" button.
   * @param {string} gridId - The ID of the container grid.
   * @param {number} showCount - Number of posts to show per click.
   */
  function initShowMore(buttonId, gridId, showCount = 8) {
    const showMoreBtn = document.getElementById(buttonId);
    const grid = document.getElementById(gridId);

    if (showMoreBtn && grid) {
      showMoreBtn.addEventListener("click", () => {
        const hiddenPosts = grid.querySelectorAll(".hidden-post");
        
        // Show the next showCount posts or all if fewer remain
        for (let i = 0; i < showCount && i < hiddenPosts.length; i++) {
          hiddenPosts[i].classList.remove("hidden-post");
        }

        // Hide button container if no more hidden posts
        if (grid.querySelectorAll(".hidden-post").length === 0) {
          showMoreBtn.parentElement.style.display = "none";
        }
      });
    }
  }

  // Initialize for Video Blog
  initShowMore("show-more-video-btn", "video-blog-grid", 8);

  // Initialize for Recent Posts
  initShowMore("show-more-recent-posts-btn", "recent-posts-grid", 8);
});
