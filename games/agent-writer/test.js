const RiveScript = require("rivescript");
const bot = new RiveScript();
bot.stream(`
+ *
- [random] you said something unknown {topic=random}

> topic robot
  + yes
  - {topic=random}{@ test string}{topic=robot} \nAre you a robot?
  + *
  - [robot] you said something unknown
< topic

+ set robot
- {topic=robot} done
`);
bot.sortReplies();
bot.reply("user", "set robot").then(console.log);
bot.reply("user", "yes").then(console.log);
bot.reply("user", "test string").then(console.log);
