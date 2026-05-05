const puppeteer = require('puppeteer');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  page.on('console', msg => console.log('BROWSER LOG:', msg.text()));
  page.on('pageerror', err => console.log('BROWSER ERROR:', err.message));
  
  await page.goto('http://localhost:3001/');
  
  // Wait for the button to appear and click it
  await page.waitForSelector('#start-btn');
  await page.click('#start-btn');
  
  // Wait a little bit to collect errors
  await new Promise(resolve => setTimeout(resolve, 2000));
  
  await browser.close();
})();
