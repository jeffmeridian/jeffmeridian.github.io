const puppeteer = require('puppeteer');
const fs = require('fs');

(async () => {
  const browser = await puppeteer.launch();
  const page = await browser.newPage();
  page.on('console', msg => console.log('BROWSER LOG:', msg.text()));
  page.on('pageerror', err => console.log('BROWSER ERROR:', err.message));
  
  await page.goto('http://localhost:3001/');
  
  // click start
  await page.waitForSelector('#start-btn');
  await page.click('#start-btn');
  
  await new Promise(resolve => setTimeout(resolve, 2000)); // wait for first enemy
  
  // press Z to shoot
  await page.keyboard.press('z');
  await new Promise(resolve => setTimeout(resolve, 500));
  await page.keyboard.press('z');
  
  await new Promise(resolve => setTimeout(resolve, 1000));
  
  await page.screenshot({path: 'screenshot_test.png'});
  
  await browser.close();
})();
