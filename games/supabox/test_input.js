const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  page.on('console', msg => console.log('BROWSER LOG:', msg.text()));
  page.on('pageerror', err => console.log('BROWSER ERROR:', err.message));
  page.on('requestfailed', request => {
    console.log('FAILED REQUEST:', request.url(), request.failure()?.errorText, request.response()?.status());
  });
  
  await page.goto('http://localhost:3001/');
  
  await page.waitForSelector('#start-btn');
  await page.click('#start-btn');
  
  await new Promise(resolve => setTimeout(resolve, 500));
  
  await browser.close();
})();
