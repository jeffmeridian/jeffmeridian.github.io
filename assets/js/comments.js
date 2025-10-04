// A simple function to prevent HTML injection by escaping < and >
function sanitizeHTML(str) {
  return str.replace(/</g, "&lt;").replace(/>/g, "&gt;");
}

document.addEventListener("DOMContentLoaded", () => {
  const commentsContainer = document.getElementById("comments-container");
  const commentForm = document.getElementById("comment-form");
  const postIDInput = document.getElementById("postID");

  const postID = postIDInput ? postIDInput.value : null;

  if (commentsContainer && postID) {
    fetchAndDisplayComments(postID);
  }

  if (commentForm) {
    commentForm.addEventListener("submit", (e) => {
      e.preventDefault();
      submitComment();
    });
  }
});

async function fetchAndDisplayComments(postID) {
  const fetchURL = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ782-x2GUGm8qkH78IOzdGRfyepGUpA1Eh1RqM0xYuRTCU3O2K9NOmoB-vsQUJsbZflUTbfGX6ersi/pub?output=csv";

  try {
    const response = await fetch(fetchURL);
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    const csvText = await response.text();
    const comments = parseCSV(csvText);

    const postComments = comments.filter(comment => {
      const sheetPostID = (comment.postID || '').trim().replace(/\/$/, '');
      const pagePostID = (postID || '').trim().replace(/\/$/, '');
      return sheetPostID === pagePostID;
    });

    displayComments(postComments);

  } catch (error) {
    console.error("Failed to fetch or parse comments:", error);
    document.getElementById("comments-list").innerHTML = "<p>Could not load comments.</p>";
  }
}

/**
 * A robust CSV parser that correctly handles multi-line fields and quoted values.
 * @param {string} csvText The raw CSV text data.
 * @returns {Array} An array of comment objects.
 */
function parseCSV(csvText) {
  // --- STEP 1: Intelligently reconstruct the rows ---
  const rawLines = csvText.trim().split(/\r?\n/);
  const actualRows = [];
  let currentRow = '';

  for (const line of rawLines) {
    currentRow += line;
    // Count the number of quotes in the current, stitched-together row.
    // If the count is even, it's a complete row.
    if (currentRow.split('"').length % 2 !== 0) {
      actualRows.push(currentRow);
      currentRow = '';
    } else {
      // If the quote count is odd, we're inside a multi-line field.
      // Add a newline character back so it's preserved in the comment.
      currentRow += '\n';
    }
  }

  // --- STEP 2: Process the reconstructed rows ---
  const headers = actualRows[0].split(",").map(header => header.trim());
  const postIDIndex = headers.indexOf("PostID");
  const nameIndex = headers.indexOf("Name");
  const ratingIndex = headers.indexOf("Rating");
  const commentIndex = headers.indexOf("Comment");
  const timestampIndex = headers.indexOf("Timestamp");

  // This regex splits a row by commas, but ignores commas inside quotes.
  const columnRegex = /,(?=(?:(?:[^"]*"){2})*[^"]*$)/;

  return actualRows.slice(1).map(row => {
    const columns = row.split(columnRegex);

    const cleanValue = (str) => {
      if (typeof str !== 'string') return '';
      // Remove quotes from the start/end and un-escape double-quotes.
      return str.replace(/^"|"$/g, '').replace(/""/g, '"');
    };
    
    return {
      postID: cleanValue(columns[postIDIndex]),
      name: cleanValue(columns[nameIndex]),
      rating: parseInt(cleanValue(columns[ratingIndex]), 10),
      comment: cleanValue(columns[commentIndex]),
      timestamp: cleanValue(columns[timestampIndex])
    };
  });
}
function displayComments(comments) {
  const commentsList = document.getElementById("comments-list");
  const averageRatingElem = document.getElementById("average-rating");
  
  if (!comments || comments.length === 0) {
    commentsList.innerHTML = "<p>Be the first to leave a comment!</p>";
    averageRatingElem.innerHTML = "No ratings yet.";
    return;
  }

  const totalRating = comments.reduce((sum, comment) => sum + (comment.rating || 0), 0);
  const averageRating = (totalRating / comments.length).toFixed(1);
  averageRatingElem.innerHTML = `Average Rating: ${averageRating} / 6 ★ (${comments.length} reviews)`;

  commentsList.innerHTML = comments.reverse().map(comment => {
    const sanitizedName = sanitizeHTML(comment.name || 'Anonymous');
    const sanitizedComment = sanitizeHTML(comment.comment || '');
    const characterLimit = 500;
    
    let commentHTML;
    if (sanitizedComment.length > characterLimit) {
      // --- THIS IS THE FINAL FIX ---
      // We now escape BOTH double quotes and newline characters for the data attribute.
      const escapedFullText = sanitizedComment.replace(/"/g, '&quot;').replace(/\n/g, '&#10;');
      const truncatedText = sanitizedComment.substring(0, characterLimit) + '...';
      
      commentHTML = `
        <div class="comment-text" data-full-text="${escapedFullText}">
          ${truncatedText}
        </div>
        <button class="show-more-btn">Show More</button>
      `;
    } else {
      commentHTML = `<div class="comment-text">${sanitizedComment.replace(/\n/g, '<br>')}</div>`;
    }

    return `
      <div class="comment">
        <p class="comment-meta">
          <strong>${sanitizedName}</strong>
          <span class="comment-rating">${'★'.repeat(comment.rating || 0)}${'☆'.repeat(6 - (comment.rating || 0))}</span>
        </p>
        ${commentHTML}
      </div>
    `;
  }).join('');

  commentsList.addEventListener('click', function(event) {
    if (event.target.classList.contains('show-more-btn')) {
      const button = event.target;
      const commentTextDiv = button.previousElementSibling;
      const fullText = commentTextDiv.dataset.fullText;
      
      // When we set the content, we need to replace the newline entity with a <br> tag for display.
      commentTextDiv.innerHTML = fullText.replace(/&#10;/g, '<br>');
      button.style.display = 'none';
    }
  });
}


async function submitComment() {
  const formActionURL = "https://docs.google.com/forms/u/0/d/e/1FAIpQLSdd1YkQ5gy4hdN_wOQgFuPD4USyGmyks9466b8NrrShW41pQw/formResponse";
  const nameEntry = "entry.892142130";
  const commentEntry = "entry.1424157928";
  const ratingEntry = "entry.1128392642";
  const postIDEntry = "entry.1858208286";

  const form = document.getElementById("comment-form");
  const formData = new FormData();

  formData.append(postIDEntry, form.elements["postID"].value);
  formData.append(nameEntry, form.elements["name"].value);
  formData.append(commentEntry, form.elements["comment"].value);
  formData.append(ratingEntry, form.elements["rating"].value);

  try {
    await fetch(formActionURL, {
      method: "POST",
      mode: "no-cors",
      body: formData,
    });
    
    alert("Thank you! Your comment has been submitted.");
    form.reset();
    
    const postID = form.elements["postID"].value;
    setTimeout(() => {
      document.getElementById("comments-list").innerHTML = "<p>Refreshing comments...</p>";
      fetchAndDisplayComments(postID);
    }, 2000);

  } catch (error) {
    console.error("Error submitting form:", error);
    alert("There was an error submitting your comment. Please try again.");
  }
}