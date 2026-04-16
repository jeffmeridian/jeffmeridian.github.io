import os

file_path = "/Users/kai/Development/writer-studio/eleventy/site/games/maumau/index.html"
with open(file_path, "r") as f:
    content = f.read()

i18n_script = """
    const i18n = {
      de: {
        hearts: "Herz", diamonds: "Karo", clubs: "Kreuz", spades: "Pik",
        noCards: "Keine Karten mehr verfügbar!",
        reshuffleProblem: "Keine Karten mehr verfügbar! (Reshuffle Problem)",
        popUndefined: "Keine Karten mehr verfügbar! (Pop undefined)",
        yourCards: "Deine Karten:",
        computerCards: "Computer Karten:",
        suitDesired: "gewünscht",
        drawCardsCount: "Karten ziehen",
        drawCardSingle: "Karte ziehen",
        invalid7Penalty: "Ungültig! Du musst {count} Karten ziehen oder eine 7 spielen.",
        youDrawPenalty: "Du ziehst {count} Karten.",
        youCounter7: "Du konterst mit 7! Computer muss {count} Karten ziehen oder 7 legen.",
        invalidSuit: "Ungültig! Gewünschte Farbe ist {suit}.",
        invalidMove: "Ungültiger Zug!",
        youPlay7: "Du spielst 7! Computer muss {count} Karten ziehen oder 7 legen.",
        youPlay8: "Du spielst eine 8 ({suit}).",
        youPlay8Again: " Du hast noch {suit}, spiele nochmal!",
        youPlay8Draw: " Keine passende Karte ({suit}). Du ziehst eine.",
        youPlayJack: "Du spielst einen Buben.",
        youPlay: "Du spielst {suit} {rank}.",
        youChooseSuit: "Du wählst {suit}.",
        computerDrawsPenalty: "Computer zieht {count} Strafkarten.",
        computerCounters7: "Computer kontert mit 7! Du musst {count} Karten ziehen oder 7 legen.",
        computerError: "Computer Kartenfehler.",
        computerPlays7: "Computer spielt 7! Du musst {count} Karten ziehen oder 7 legen.",
        computerPlays8: "Computer spielt 8.",
        computerPlays8Again: " Computer hat noch eine passende Karte und spielt nochmal!",
        computerPlays8Draw: " Computer hat keine passende Karte. Spieler ist dran.",
        computerPlaysJack: "Computer spielt Bube und wählt {suit}.",
        computerPlays: "Computer spielt {suit} {rank}.",
        computerDraws: "Computer zieht eine Karte.",
        deckEmpty: " Stapel leer.",
        youDrewCard: "Du hast eine Karte gezogen.",
        pileEmpty: "Stapel leer! Du kannst nicht ziehen.",
        mustDraw7: "Du musst {count} Karten ziehen oder 7 legen!",
        yourTurn: "Du bist am Zug.",
        computerMustDraw7: "Computer muss {count} Karten ziehen oder 7 legen.",
        computerThinking: "Computer denkt nach...",
        win: "hat gewonnen!",
        player: "Spieler",
        computer: "Computer",
        initError: "Fehler beim Spielaufbau: Keine gültige Startkarte.",
        alertInitError: "Konnte kein gültiges Startblatt finden! Deck möglicherweise leer.",
        title: "Mau Mau",
        restartGame: "Spiel neu starten",
        chooseSuit: "Wähle eine Farbe:"
      },
      en: {
        hearts: "Hearts", diamonds: "Diamonds", clubs: "Clubs", spades: "Spades",
        noCards: "No more cards available!",
        reshuffleProblem: "No more cards available! (Reshuffle Problem)",
        popUndefined: "No more cards available! (Pop undefined)",
        yourCards: "Your Cards:",
        computerCards: "Computer Cards:",
        suitDesired: "desired",
        drawCardsCount: "Draw cards",
        drawCardSingle: "Draw Card",
        invalid7Penalty: "Invalid! You must draw {count} cards or play a 7.",
        youDrawPenalty: "You draw {count} cards.",
        youCounter7: "You counter with a 7! Computer must draw {count} cards or play a 7.",
        invalidSuit: "Invalid! Desired suit is {suit}.",
        invalidMove: "Invalid move!",
        youPlay7: "You play a 7! Computer must draw {count} cards or play a 7.",
        youPlay8: "You play an 8 ({suit}).",
        youPlay8Again: " You have another {suit}, play again!",
        youPlay8Draw: " No matching card ({suit}). You draw one.",
        youPlayJack: "You play a Jack.",
        youPlay: "You play {suit} {rank}.",
        youChooseSuit: "You choose {suit}.",
        computerDrawsPenalty: "Computer draws {count} penalty cards.",
        computerCounters7: "Computer counters with a 7! You must draw {count} cards or play a 7.",
        computerError: "Computer card error.",
        computerPlays7: "Computer plays a 7! You must draw {count} cards or play a 7.",
        computerPlays8: "Computer plays an 8.",
        computerPlays8Again: " Computer has a matching card and plays again!",
        computerPlays8Draw: " Computer has no matching card. Your turn.",
        computerPlaysJack: "Computer plays a Jack and chooses {suit}.",
        computerPlays: "Computer plays {suit} {rank}.",
        computerDraws: "Computer draws a card.",
        deckEmpty: " Deck empty.",
        youDrewCard: "You drew a card.",
        pileEmpty: "Deck empty! You cannot draw.",
        mustDraw7: "You must draw {count} cards or play a 7!",
        yourTurn: "It's your turn.",
        computerMustDraw7: "Computer must draw {count} cards or play a 7.",
        computerThinking: "Computer is thinking...",
        win: "has won!",
        player: "Player",
        computer: "Computer",
        initError: "Game setup error: No valid starting card.",
        alertInitError: "Could not find a valid starting card! Deck might be empty.",
        title: "Mau Mau",
        restartGame: "Restart Game",
        chooseSuit: "Choose a suit:"
      },
      es: {
        hearts: "Corazones", diamonds: "Diamantes", clubs: "Tréboles", spades: "Picas",
        noCards: "¡No quedan más cartas!",
        reshuffleProblem: "¡No quedan más cartas! (Problema de barajar)",
        popUndefined: "¡No quedan más cartas! (Pop indefinido)",
        yourCards: "Tus cartas:",
        computerCards: "Cartas del PC:",
        suitDesired: "deseado",
        drawCardsCount: "Robar cartas",
        drawCardSingle: "Robar carta",
        invalid7Penalty: "¡Inválido! Debes robar {count} cartas o jugar un 7.",
        youDrawPenalty: "Robas {count} cartas.",
        youCounter7: "¡Contrarrestas con un 7! La PC debe robar {count} cartas o jugar un 7.",
        invalidSuit: "¡Inválido! El palo deseado es {suit}.",
        invalidMove: "¡Movimiento inválido!",
        youPlay7: "¡Juegas un 7! La PC debe robar {count} cartas o jugar un 7.",
        youPlay8: "Juegas un 8 ({suit}).",
        youPlay8Again: " Tienes otro {suit}, ¡juega de nuevo!",
        youPlay8Draw: " No hay carta correspondiente ({suit}). Robas una.",
        youPlayJack: "Juegas una Jota.",
        youPlay: "Juegas {suit} {rank}.",
        youChooseSuit: "Eliges {suit}.",
        computerDrawsPenalty: "La PC roba {count} cartas de penalización.",
        computerCounters7: "¡La PC contrarresta con un 7! Debes robar {count} cartas o jugar un 7.",
        computerError: "Error en cartas de PC.",
        computerPlays7: "¡La PC juega un 7! Debes robar {count} cartas o jugar un 7.",
        computerPlays8: "La PC juega un 8.",
        computerPlays8Again: " ¡La PC tiene carta correspondiente y juega de nuevo!",
        computerPlays8Draw: " La PC no tiene correspondencia. Tu turno.",
        computerPlaysJack: "La PC juega Jota y elige {suit}.",
        computerPlays: "La PC juega {suit} {rank}.",
        computerDraws: "La PC roba una carta.",
        deckEmpty: " Mazo vacío.",
        youDrewCard: "Has robado una carta.",
        pileEmpty: "¡Mazo vacío! No puedes robar.",
        mustDraw7: "¡Debes robar {count} cartas o jugar un 7!",
        yourTurn: "Es tu turno.",
        computerMustDraw7: "La PC debe robar {count} cartas o jugar un 7.",
        computerThinking: "La PC está pensando...",
        win: "¡ha ganado!",
        player: "Tú",
        computer: "PC",
        initError: "Error de configuración del juego: no hay carta inicial válida.",
        alertInitError: "¡No se pudo encontrar una carta inicial válida! El mazo podría estar vacío.",
        title: "Mau Mau",
        restartGame: "Reiniciar juego",
        chooseSuit: "Elige un palo:"
      }
    };

    let currentLanguage = new URLSearchParams(window.location.search).get("lang") || "de";
    document.documentElement.lang = currentLanguage;

    function t(key, params = {}) {
      let text = i18n[currentLanguage]?.[key] || i18n['de'][key] || key;
      for (const p in params) {
        text = text.replace(`{${p}}`, params[p]);
      }
      return text;
    }

    document.addEventListener("DOMContentLoaded", () => {
      document.querySelector("h1").textContent = t("title");
      document.title = t("title");
      document.getElementById("drawCardButton").textContent = t("drawCardSingle");
      document.getElementById("restartButton").textContent = t("restartGame");
      document.querySelector("#suitSelectionDialog h3").textContent = t("chooseSuit");
    });
"""

# Text replacements
replacements = [
    ('const suitTranslations = { hearts: "Herz", diamonds: "Karo", clubs: "Kreuz", spades: "Pik" };', 'const suitTranslations = { hearts: t("hearts"), diamonds: t("diamonds"), clubs: t("clubs"), spades: t("spades") };'),
    ('messageDiv.textContent = "Keine Karten mehr verfügbar!";', 'messageDiv.textContent = t("noCards");'),
    ('messageDiv.textContent = "Keine Karten mehr verfügbar! (Reshuffle Problem)";', 'messageDiv.textContent = t("reshuffleProblem");'),
    ('messageDiv.textContent = "Keine Karten mehr verfügbar! (Pop undefined)";', 'messageDiv.textContent = t("popUndefined");'),
    ('playerHandDiv.innerHTML = "<div>Deine Karten:</div>";', 'playerHandDiv.innerHTML = `<div>${t("yourCards")}</div>`;'),
    ('computerHandDiv.innerHTML = "<div>Computer Karten:</div>";', 'computerHandDiv.innerHTML = `<div>${t("computerCards")}</div>`;'),
    ('topCardDiv.innerHTML = `<div style="background: rgba(255,255,255,0.95); color: #d90000; font-weight: bold; border-radius: 5px; padding: 5px; margin-top: 10px; font-size: 16px; text-align: center; border: 2px solid #d90000;">${suitTranslations[currentSuit]}<br>gewünscht</div>`;', 'topCardDiv.innerHTML = `<div style="background: rgba(255,255,255,0.95); color: #d90000; font-weight: bold; border-radius: 5px; padding: 5px; margin-top: 10px; font-size: 16px; text-align: center; border: 2px solid #d90000;">${suitTranslations[currentSuit]}<br>${t("suitDesired")}</div>`;'),
    ('drawCardButton.textContent = `${sevenPenaltyDrawCount} Karten ziehen`;', 'drawCardButton.textContent = `${sevenPenaltyDrawCount} ${t("drawCardsCount")}`;'),
    ('drawCardButton.textContent = "Karte ziehen";', 'drawCardButton.textContent = t("drawCardSingle");'),
    ('messageDiv.textContent = `Ungültig! Du musst ${sevenPenaltyDrawCount} Karten ziehen oder eine 7 spielen.`;', 'messageDiv.textContent = t("invalid7Penalty", { count: sevenPenaltyDrawCount });'),
    ('messageDiv.textContent = `Du ziehst ${sevenPenaltyDrawCount} Karten.`;', 'messageDiv.textContent = t("youDrawPenalty", { count: sevenPenaltyDrawCount });'),
    ('actionMessage = `Du konterst mit 7! Computer muss ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen.`;', 'actionMessage = t("youCounter7", { count: sevenPenaltyDrawCount });'),
    ('messageDiv.textContent = `Ungültig! Gewünschte Farbe ist ${suitTranslations[currentSuit]}.`;', 'messageDiv.textContent = t("invalidSuit", { suit: suitTranslations[currentSuit] });'),
    ('messageDiv.textContent = "Ungültiger Zug!";', 'messageDiv.textContent = t("invalidMove");'),
    ('actionMessage = `Du spielst 7! Computer muss ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen.`;', 'actionMessage = t("youPlay7", { count: sevenPenaltyDrawCount });'),
    ('actionMessage = `Du spielst eine 8 (${suitTranslations[suitOfEight]}).`;', 'actionMessage = t("youPlay8", { suit: suitTranslations[suitOfEight] });'),
    ('messageDiv.textContent = actionMessage + ` Du hast noch ${suitTranslations[suitOfEight]}, spiele nochmal!`;', 'messageDiv.textContent = actionMessage + t("youPlay8Again", { suit: suitTranslations[suitOfEight] });'),
    ('messageDiv.textContent = actionMessage + ` Keine passende Karte (${suitTranslations[suitOfEight]}). Du ziehst eine.`;', 'messageDiv.textContent = actionMessage + t("youPlay8Draw", { suit: suitTranslations[suitOfEight] });'),
    ('actionMessage = `Du spielst einen Buben.`;', 'actionMessage = t("youPlayJack");'),
    ('actionMessage = `Du spielst ${suitTranslations[card.suit]} ${card.rank}.`;', 'actionMessage = t("youPlay", { suit: suitTranslations[card.suit], rank: card.rank });'),
    ('messageDiv.textContent = `Du wählst ${suitTranslations[currentSuit]}.`;', 'messageDiv.textContent = t("youChooseSuit", { suit: suitTranslations[currentSuit] });'),
    ('actionMessage = `Computer kontert mit 7! Du musst ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen.`;', 'actionMessage = t("computerCounters7", { count: sevenPenaltyDrawCount });'),
    ('actionMessage = `Computer zieht ${sevenPenaltyDrawCount} Strafkarten.`;', 'actionMessage = t("computerDrawsPenalty", { count: sevenPenaltyDrawCount });'),
    ('actionMessage = "Computer Kartenfehler.";', 'actionMessage = t("computerError");'),
    ('actionMessage = `Computer spielt 7! Du musst ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen.`;', 'actionMessage = t("computerPlays7", { count: sevenPenaltyDrawCount });'),
    ('actionMessage = `Computer spielt 8.`;', 'actionMessage = t("computerPlays8");'),
    ('messageDiv.textContent = actionMessage + ` Computer hat noch eine passende Karte und spielt nochmal!`;', 'messageDiv.textContent = actionMessage + t("computerPlays8Again");'),
    ('messageDiv.textContent = actionMessage + ` Computer hat keine passende Karte. Spieler ist dran.`;', 'messageDiv.textContent = actionMessage + t("computerPlays8Draw");'),
    ('actionMessage = `Computer spielt Bube und wählt ${suitTranslations[currentSuit]}.`;', 'actionMessage = t("computerPlaysJack", { suit: suitTranslations[currentSuit] });'),
    ('actionMessage = `Computer spielt ${suitTranslations[cardToPlay.suit]} ${cardToPlay.rank}.`;', 'actionMessage = t("computerPlays", { suit: suitTranslations[cardToPlay.suit], rank: cardToPlay.rank });'),
    ('actionMessage = "Computer zieht eine Karte.";', 'actionMessage = t("computerDraws");'),
    ('actionMessage += " Stapel leer.";', 'actionMessage += t("deckEmpty");'),
    ('messageDiv.textContent = "Du hast eine Karte gezogen.";', 'messageDiv.textContent = t("youDrewCard");'),
    ('messageDiv.textContent = "Stapel leer! Du kannst nicht ziehen.";', 'messageDiv.textContent = t("pileEmpty");'),
    ('messageDiv.textContent = `Du musst ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen!`;', 'messageDiv.textContent = t("mustDraw7", { count: sevenPenaltyDrawCount });'),
    ('messageDiv.textContent = "Du bist am Zug.";', 'messageDiv.textContent = t("yourTurn");'),
    ('messageDiv.textContent = `Computer muss ${sevenPenaltyDrawCount} Karten ziehen oder 7 legen.`;', 'messageDiv.textContent = t("computerMustDraw7", { count: sevenPenaltyDrawCount });'),
    ('messageDiv.textContent = "Computer denkt nach...";', 'messageDiv.textContent = t("computerThinking");'),
    ('messageDiv.textContent = `${winner} hat gewonnen!`;', 'messageDiv.textContent = `${winner === "Spieler" ? t("player") : t("computer")} ${t("win")}`;'),
    ('alert("Konnte kein gültiges Startblatt finden! Deck möglicherweise leer.");', 'alert(t("alertInitError"));'),
    ('messageDiv.textContent = "Fehler beim Spielaufbau: Keine gültige Startkarte.";', 'messageDiv.textContent = t("initError");')
]

for src, dist in replacements:
    content = content.replace(src, dist)

# Insert the i18n script at the top of the script tag
script_start = content.find("<script>")
if script_start != -1:
    content = content[:script_start + 8] + "\n" + i18n_script + content[script_start + 8:]

with open(file_path, "w") as f:
    f.write(content)

print("Done")
