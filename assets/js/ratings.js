javascript
exports.handler = async function(event, context) {
    if (event.httpMethod !== "POST") {
        return { statusCode: 405, body: "Method Not Allowed" };
    }
    try {
        const data = JSON.parse(event.body);
        const { rating, comment } = data;

        // TODO: Initialize Google Sheets API client and authenticate
         const { GoogleSheets } = require('google-sheets');
         const sheets = new GoogleSheets({ /* auth options */ });

        // Replace 'YOUR_SHEET_ID' with your Google Sheet ID
        const YOUR_SHEET_ID = 'YOUR_SHEET_ID';

        // Example: append rows to the spreadsheet
        await sheets.spreadsheets.values.append({
            spreadsheetId: YOUR_SHEET_ID,
            range: 'Sheet1!A1', // Adjust the range as needed
            valueInputOption: 'RAW',
            resource: {
                values: [[new Date().toISOString(), rating, comment]],
            },
        });

        return { statusCode: 200, body: JSON.stringify({ message: "Rating saved successfully!" }) };
    } catch (error) {
        console.error("Error saving rating:", error);
        return { statusCode: 500, body: JSON.stringify({ error: "Failed to save rating." }) };
    }
};