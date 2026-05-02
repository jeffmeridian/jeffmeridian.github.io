document.addEventListener("DOMContentLoaded", () => {
  const showMoreBtn = document.getElementById("show-more-video-btn");
  const videoGrid = document.getElementById("video-blog-grid");

  if (showMoreBtn && videoGrid) {
    showMoreBtn.addEventListener("click", () => {
      const hiddenPosts = videoGrid.querySelectorAll(".hidden-post");
      
      // Show the next 8 posts or all if fewer than 8 remain
      for (let i = 0; i < 8 && i < hiddenPosts.length; i++) {
        hiddenPosts[i].classList.remove("hidden-post");
      }

      // Hide button if no more hidden posts
      if (videoGrid.querySelectorAll(".hidden-post").length === 0) {
        showMoreBtn.parentElement.style.display = "none";
      }
    });
  }
});
