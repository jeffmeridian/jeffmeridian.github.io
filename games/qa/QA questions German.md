# QA-Interview-Fragen und Antworten

*Satz von 180 gezielten QA- / Test-Manager-Interviewfragen mit vorgeschlagenen Antworten.*

---

## Allgemeine QA-Grundlagen (1–20)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 1 | Was ist der Unterschied zwischen Quality Assurance (Qualitätssicherung) und Quality Control (Qualitätskontrolle)? | QA ist prozessorientiert (Fehler vermeiden). QC ist produktorientiert (Fehler erkennen). |
| 2 | Was sind die Phasen des Software Testing Life Cycle (STLC)? | Anforderungsanalyse, Testplanung, Testfallentwurf, Umgebungseinrichtung, Durchführung, Fehlerverfolgung und Abschluss. |
| 3 | Wie entscheiden Sie, was getestet werden soll? | Analyse von Anforderungen, Geschäftsrisiko, Benutzerauswirkungen und historischen Fehlerdaten, um einen priorisierten Abdeckungsplan zu definieren. |
| 4 | Was macht einen guten Testfall aus? | Einer, der klar, prägnant und wiederholbar ist und eine bestimmte Anforderung oder ein bestimmtes Verhalten mit messbaren erwarteten Ergebnissen verifiziert. |
| 5 | Erklären Sie die Grenzwertanalyse (Boundary Value Analysis). | Testen von Eingaben direkt an/außerhalb von Grenzen, um Randfallfehler aufzudecken. |
| 6 | Erklären Sie die Äquivalenzklassenbildung (Equivalence Partitioning). | Aufteilung der Eingabedaten in gültige und ungültige Partitionen, um Redundanz zu reduzieren und gleichzeitig eine hohe Abdeckung aufrechtzuerhalten. |
| 7 | Was ist der Unterschied zwischen Regressionstests und Retesting? | Regressionstests prüfen nicht betroffene Bereiche auf Stabilität; Retesting verifiziert spezifische Fehlerbehebungen. |
| 8 | Wie gehen Sie an negatives Testen heran? | Entwurf von Szenarien, die absichtlich ungültige Eingaben oder Aktionen verwenden, um eine fehlerfreie Handhabung und Robustheit sicherzustellen. |
| 9 | Was bedeuten Schweregrad (Severity) und Priorität (Priority) im Fehlermanagement? | Schweregrad = technische Auswirkung; Priorität = geschäftliche Dringlichkeit der Behebung. |
| 10 | Wie definieren Sie eine Metrik für die Testabdeckung? | Verhältnis von ausgeführten Testfällen / Gesamtheit der zugeordneten Anforderungen, ausgedrückt als Prozentsatz. |
| 11 | Wie stellen Sie die Rückverfolgbarkeit von Anforderungen (Requirements Traceability) sicher? | Pflege einer Rückverfolgbarkeitsmatrix (Traceability Matrix), die Anforderungen → Testfälle → Fehler → Ergebnisse verknüpft. |
| 12 | Was ist exploratives Testen? | Ad-hoc- aber strukturiertes Testen zur Entdeckung unbekannter Fehler durch die Kreativität des Testers. |
| 13 | Wie validieren Sie die Datenintegrität nach einer Migration? | Verwendung von Zeilenanzahlen, Prüfsummen und Stichproben zwischen Quell- und Zieldatenbanken. |
| 14 | Wie gehen Sie mit unvollständigen Anforderungen um? | Annahmen klären, Tests für bekannte Geschäftsregeln erstellen und iterativ mit Stakeholdern abstimmen. |
| 15 | Welche Teststufen gibt es im SDLC? | Unit-, Integrations-, System-, Abnahme-, Smoke-, Regressions- und nicht-funktionale Tests. |
| 16 | Wie legen Sie die Kriterien für den Testabschluss (Test Completion Criteria) fest? | Basierend auf den im Plan definierten Kriterien: Abdeckungsziele, Fehlerdichte und Bestehensquoten-Schwellenwerte. |
| 17 | Wie verwalten Sie Risiken beim Testen? | Risiken identifizieren (Anforderungen, Technologie, Ressourcen), nach Auswirkung × Wahrscheinlichkeit bewerten und Tests entsprechend priorisieren. |
| 18 | Erklären Sie Shift-Left-Testing. | Frühzeitige Integration von Tests im SDLC: Reviews, statische Analysen und frühe Automatisierung. |
| 19 | Was sind gängige Arten der Testdokumentation? | Teststrategie, Testplan, Testfälle, Testdaten, Zusammenfassungsberichte, RTM und Abschlussdokumente. |
| 20 | Was ist der Hauptvorteil der Testautomatisierung? | Geschwindigkeit, Konsistenz und Regressionszuverlässigkeit bei reduziertem manuellem Aufwand. |

---

## Testautomatisierung und Tools (21–40)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 21 | Welche Tools haben Sie für die Automatisierung verwendet? | Selenium, Playwright, Cypress, Postman, k6 und Integration von Azure DevOps Pipelines. |
| 22 | Wie entwerfen Sie wartbare automatisierte Tests? | Page-Object-Abstraktion, wiederverwendbare Funktionen, stabile Locators und sauberer Datenaufbau/-abbau. |
| 23 | Welches Framework-Design bevorzugen Sie? | Hybrides, modulares, datengesteuertes Framework: kombiniert Parametrisierung mit wiederverwendbaren Bibliotheken. |
| 24 | Wie gehen Sie mit dynamischen Elementen in der Automatisierung um? | Explizite Wartezeiten (Explicit Waits), intelligente Locators (CSS/XPath) und Wiederholungsmechanismen. |
| 25 | Wie integrieren Sie Automatisierung in CI/CD-Pipelines? | Trigger bei Commit/Merge einrichten, HTML-Berichte veröffentlichen und Builds bei kritischen Testergebnissen blockieren. |
| 26 | Wie gehen Sie an das Testen von APIs heran? | Validierung von Antwortcodes, Schemata, Grenzwerten und Verkettung von Szenarien; Tools: Postman, REST Assured. |
| 27 | Was sind die Vorteile von BDD (Behavior-Driven Development)? | Verbessert die Zusammenarbeit und Lesbarkeit; verwendet Gherkin-Syntax (Given/When/Then). |
| 28 | Wie verwalten Sie Testdaten für die Automatisierung? | Verwendung dedizierter Testdatensätze, Zufallsgeneratoren oder synthetischer Testdaten-Frameworks. |
| 29 | Wie messen Sie den ROI der Testautomatisierung? | Vergleich des eingesparten Aufwands mit den Kosten für die manuelle Durchführung; Verfolgung von Abdeckung und Nutzungshäufigkeit. |
| 30 | Welche Arten von Tests sollten nicht automatisiert werden? | Schnell wechselnde UIs, einmalige Validierungen und Szenarien mit geringem ROI. |
| 31 | Wie gehen Sie mit instabilen Tests (Flaky Tests) um? | Ursache identifizieren, Timing-/Datenabhängigkeiten stabilisieren, isolieren (Quarantäne) und Tests refaktorieren. |
| 32 | Wie nutzen Sie Versionskontrolle bei Tests? | Speicherung von Skripten in Git; Nutzung von Pull Requests und Code-Reviews für Teständerungen. |
| 33 | Welche Berichts-Tools haben Sie verwendet? | Allure, ExtentReports, Azure Test Plans, Power BI Dashboards. |
| 34 | Wie verifizieren Sie die Stabilität der CI? | Überwachung der Build-Bestehensquote, Analyse von Pipeline-Logs und Reduzierung von Engpässen in der Testsuite. |
| 35 | Was sind Testdoubles? | Stubs, Mocks und Fakes, die zur Isolierung von Komponenten während Integrationstests verwendet werden. |
| 36 | Wie testen Sie APIs mit Authentifizierung? | Verwendung von tokenbasierter Authentifizierung in Postman oder Testskripten; Validierung von erfolgreichem und unbefugtem Zugriff. |
| 37 | Warum nutzen Sie datengesteuertes Testen (Data-Driven Testing)? | Wiederverwendung derselben Logik für mehrere Datensätze und Eingaben, um die Abdeckung effizient zu maximieren. |
| 38 | Was ist Continuous Testing? | Automatische Durchführung von Tests während des gesamten SDLC- und CI/CD-Lebenszyklus. |
| 39 | Wie sieht Ihre Testautomatisierungsstrategie für Microservices aus? | Tests auf API-Ebene, Kontraktvalidierung und End-to-End-Integrationsflusstests. |
| 40 | Was ist ein Smoke-Test in der Automatisierung? | Eine Reihe minimaler Prüfungen zur Verifizierung der Hauptfunktionen vor tiefergehenden Tests. |

---

## Agile, DevOps und Zusammenarbeit (41–60)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 41 | Was ist Ihre Rolle als QA in Agile? | Kollaborateur, nicht Gatekeeper: Hilfestellung bei der Definition von Akzeptanzkriterien, Testautomatisierung und Sicherstellung integrierter Qualität. |
| 42 | Wie schreiben Sie testbare User Stories? | Klare Akzeptanzkriterien und messbare Ergebnisse einbeziehen. |
| 43 | Erklären Sie den Unterschied zwischen Scrum und Kanban. | Scrum: zeitlich begrenzte Sprints; Kanban: kontinuierlicher Fluss zur Optimierung von WIP-Limits (Work in Progress). |
| 44 | Wie arbeiten Sie während eines Sprints mit Entwicklern zusammen? | Täglicher Sync, Pair-Testing und frühzeitiges Feedback zu Stories vor dem Merge. |
| 45 | Wie unterstützt QA die Einführung von CI/CD? | Durch Erstellung automatisierter Quality Gates und Überwachung von Post-Deployment-Metriken. |
| 46 | Wie stellen Sie schnelle Feedbackschleifen sicher? | Kurze Testsuiten, Staging-Umgebungen und Alarmierungs-Dashboards. |
| 47 | Was ist eine Definition of Done (DoD)? | Eine gemeinsame Checkliste, die sicherstellt, dass jede Story den Qualitäts- und Bereitstellungsanforderungen entspricht. |
| 48 | Wie gehen Sie mit blockierten Stories aufgrund von Umgebungsproblemen um? | Frühzeitig eskalieren, alternative Aufgaben übernehmen und Blockaden im Stand-up melden. |
| 49 | Wie schätzen Sie den Testaufwand in Agile? | Verwendung von Story Points oder T-Shirt-Größen, abgestimmt auf Teamkapazität und historische Velocity. |
| 50 | Wie planen Sie Tests in Agile? | Rolling-Wave-Planung in jedem Sprint mit aktualisiertem Risiko und Umfang gemäß Backlog Refinement. |
| 51 | Wie gehen Sie mit Fehlern um, die mitten im Sprint entdeckt werden? | Sofort protokollieren, mit Entwicklern zusammenarbeiten, um sie innerhalb des Sprints zu beheben, andernfalls für den nächsten Sprint einplanen. |
| 52 | Wie pflegen Sie Qualitätsmetriken in Agile? | Verfolgung von entwischten Fehlern (Escaped Defects), Automatisierungs-Bestehensquote, Abdeckung und Team-Feedback in Retrospektiven. |
| 53 | Wie nutzen Sie CI/CD-Metriken zur Bewertung der Qualitätsgesundheit? | Build-Bestehensquote, Zeit bis zur Behebung, Bereitstellungshäufigkeit und MTTR (Mean Time to Repair). |
| 54 | Wie bewerten Sie die Release-Bereitschaft in DevOps? | Validierung von Test- und Bereitstellungsnachweisen, Rollback-Prüfungen und Bereitschaftskriterien auf dem Release-Board. |
| 55 | Wie bauen Sie eine Zusammenarbeit über Zeitzonen hinweg auf? | Gemeinsame Dokumentation, asynchrone Updates, flexible Übergabe-Checklisten. |
| 56 | Welche QA-Engpässe haben Sie in der CI beseitigt? | Reduzierung der Regressionslaufzeit durch Parallelisierung und dynamische Testauswahl. |
| 57 | Wie fördern Sie eine Qualitätskultur? | Datenbasierte Metriken, Demonstration des QA-Einflusses und positive Sichtbarkeit von Testergebnissen. |
| 58 | Was ist Shift-Right-Testing? | Testen in der Produktion: synthetisches Monitoring, Canary-Deployment-Validierung und telemetriebasiertes Feedback. |
| 59 | Wie überwachen Sie die Qualität in der Produktion? | Analyse von Logs, Fehlertrends und Kunden-KPIs; Rückführung der Erkenntnisse in das Testdesign. |
| 60 | Wie würden Sie Entwickler ermutigen, bessere Tests zu schreiben? | Fokus auf Unit-Abdeckung bei Code-Reviews, Pair-Programming und gemeinsame Testverantwortung. |

---

## Performance, Sicherheit und Compliance (61–80)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 61 | Was sind gängige Arten von Performance-Tests? | Last-, Stress-, Ausdauer-, Peak- (Spike) und Skalierbarkeitstests. |
| 62 | Welche Tools nutzen Sie für Performance-Tests? | k6, JMeter, Gatling und Azure Load Testing. |
| 63 | Welche Metriken sind beim Auslastungstest wichtig? | Antwortzeit, Durchsatz, Fehlerrate und Ressourcenauslastung. |
| 64 | Wie identifizieren Sie Performance-Engpässe? | Analyse von Logs, APM-Dashboards und Systemmetriken, die mit den Testdaten korrelieren. |
| 65 | Wie gehen Sie an Sicherheitsprüfungen in der QA heran? | OWASP-Checkliste, Schwachstellenscan, Eingabevalidierung und das Prinzip der minimalen Rechtevergabe. |
| 66 | Wie testen Sie die Sicherheit der Authentifizierung? | Prüfung auf abgelaufene Token, Brute-Force-Resistenz und korrekte Verschlüsselung. |
| 67 | Wie stellen Sie Compliance-Tests sicher (z. B. DSGVO)? | Validierung von Datenanonymisierung, Benutzereinwilligungsflüssen und Audit-Logs. |
| 68 | Wie testen Sie die Auslastungsresistenz von APIs? | Schrittweise Erhöhung der Parallelität, Messung der Latenz und Überwachung von Fehlerschwellenwerten. |
| 69 | Wie gehen Sie mit fehlgeschlagenen Performance-Benchmarks um? | Profilierung von Komponenten, Optimierung von Abfragen, sicheres Caching und iteratives Nachtesten. |
| 70 | Wie sichern Sie Testumgebungen ab? | Isolation von der Produktion, Anonymisierung von Daten und Durchsetzung von Zugriffskontrollen. |
| 71 | Wie verwalten Sie Sicherheitsregressionen? | Integration von Scans (SAST, DAST) in CI/CD; Trendanalyse und Triage der Ergebnisse nach Schweregrad. |
| 72 | Wie testen Sie die Robustheit von Verschlüsselung? | Verifizierung von Algorithmen, Schlüsselrotation und sicheren Richtlinien zur Schlüsselverwaltung. |
| 73 | Was ist Fuzz-Testing? | Senden von zufälligen/ungültigen Daten zur Überprüfung von Robustheit und Fehlerbehandlung. |
| 74 | Wie reduzieren Sie Falsch-Positive bei Sicherheits-Scans? | Anpassung der Scan-Regeln und manuelle Validierung der Ergebnisse vor der Risikobewertung. |
| 75 | Wie testen Sie Sitzungs-Timeouts? | Inaktivität simulieren und sicherstellen, dass der Sitzungsablauf mit den Richtlinien übereinstimmt. |
| 76 | Welche Sicherheits-Frameworks befolgen Sie? | OWASP Top 10, NIST 800-53, CIS Benchmarks. |
| 77 | Wie stellen Sie Audit-Bereitschaft sicher? | Pflege rückverfolgbarer Testartefakte, Nachweisprotokolle und wiederholbarer Ausführungsberichte. |
| 78 | Was ist Ihr Plan für nicht-funktionale Tests in Sprints? | NFR-Stories definieren, leichte NFR-Sanity-Prüfungen in jedem Sprint, vollständige Suite vor großen Releases. |
| 79 | Wie arbeiten Sie mit InfoSec zusammen? | Austausch von Testnachweisen, Abstimmung der Risikopriorisierung und gemeinsame Verantwortung für SLAs zur Behebung von Schwachstellen. |
| 80 | Wie stellen Sie sicher, dass Compliance-Dokumentation aktuell bleibt? | Automatisierung der Nachweiserstellung und Verknüpfung mit Kontrollen in Power BI oder Confluence. |

---

## Test-Leadership und Management (81–100)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 81 | Wie messen Sie die Leistung des QA-Teams? | Vorhersagbarkeit der Lieferung, Verbesserung der Abdeckung und Reduzierung des Geschäftsrisikos. |
| 82 | Was macht einen Testmanager erfolgreich? | Vision, Kommunikation, Risikokompetenz und Prozessanpassungsfähigkeit. |
| 83 | Wie motivieren Sie Tester? | Anerkennung von Beiträgen, Verfolgung von Ergebnissen, Ermöglichung von Kompetenzwachstum und Rotation herausfordernder Aufgaben. |
| 84 | Wie verbessern Sie die Genauigkeit von Testschätzungen? | Analyse historischer Daten, Story-basierte Schätzung, Puffer für Unbekanntes. |
| 85 | Wie richten Sie QA-OKRs an den Unternehmenszielen aus? | Zuordnung zu strategischen Metriken wie Release-Stabilität und Kundenzufriedenheit. |
| 86 | Wie betreuen Sie einen Junior-QA-Ingenieur? | Partnerschaft bei der Testplanung, Förderung der Eigenverantwortung und Review-Feedback zum Testdesign. |
| 87 | Wie lösen Sie Konflikte zwischen QA und Entwicklung? | Förderung datengestützter Diskussionen, Fokus auf die Auswirkungen statt auf Schuldzuweisungen. |
| 88 | Wie arbeiten Sie neue QA-Mitarbeiter ein? | Strukturierter 30-60-90-Tage-Plan, der Tools, Workflows und Kultur abdeckt. |
| 89 | Wie gehen Sie mit wechselnden Prioritäten in Teams um? | Transparente Repriorisierung des Backlogs und frühzeitige Eskalation. |
| 90 | Wie berichten Sie den QA-Einfluss an die Geschäftsführung? | Wöchentliches Dashboard, das Metriken mit Geschäfts-KPIs und dem Risikoprofil verknüpft. |
| 91 | Wie skaliere ich QA mit dem Wachstum? | Automation-First-Mentalität, Standardisierung von Test-Frameworks und Übertragung der Verantwortung auf Squad-Tester. |
| 92 | Wie sichern Sie Konsistenz in verteilten Testteams? | Governance-Vorlagen, gemeinsame Dashboards und regelmäßige Qualitäts-Syncs. |
| 93 | Wie bewerten Sie die QA-Reife eines Projekts? | Bewertung von Abdeckung, Automatisierung, Metriken und Prozessausrichtung anhand eines Reifegradmodells. |
| 94 | Welche Tools nutzen Sie zur Visualisierung von Metriken? | Power BI, Grafana und Azure-Dashboards. |
| 95 | Wie kommunizieren Sie schlechte Nachrichten effektiv? | Verwendung einer neutralen, wirkungsorientierten Berichterstattung mit vorgeschlagenen Minderungsszenarien. |
| 96 | Wie kontrollieren Sie die Kosten beim Testen? | Optimierung von Umgebungen, Nutzung von Cloud-Skalierung und Vermeidung redundanter Testaufwände. |
| 97 | Wie sichern Sie die Geschäftskontinuität bei Personalfluktuation? | Cross-Training, Dokumentation von Prozessen und Pflege von Skript- und Versions-Backups. |
| 98 | Wie balancieren Sie Innovation und Standardisierung in der QA? | Standardisierung von Kernprozessen, aber Ermöglichung von Innovationen bei Tools und Methoden je nach Kontext. |
| 99 | Wie bereiten Sie sich auf Leistungsbewertungsgespräche vor? | Nutzung empirischer Daten – Metriken, Initiativen, Ergebnisse – um messbaren Einfluss zu zeigen. |
| 100 | Was ist Ihre Philosophie in Bezug auf Qualität? | Qualität liegt in der Verantwortung aller, geleitet von Sichtbarkeit, Automatisierung und kontinuierlichem Lernen. |

---

# Zusätzliche Interview-Gameplay-Fragen

## Persönliche & verhaltensbezogene Fragen

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 1 | Wie priorisieren Sie Testaufgaben, wenn sich mehrere Releases überschneiden? | Ich bewerte Risiko, geschäftliche Auswirkungen und Abhängigkeiten und verwende dann eine gewichtete Bewertungsmatrix zur Prioritätszuweisung, um sicherzustellen, dass kritische Funktionen zuerst getestet werden. |
| 2 | Beschreiben Sie eine Situation, in der Sie einen Stakeholder davon überzeugen mussten, ein Release aufgrund von Qualitätsbedenken zu verschieben. | Ich habe Daten zum Schweregrad von Fehlern, Risikoexposition und eine Kosten-Nutzen-Analyse vorgelegt, was den Produktinhaber dazu veranlasste, eine einwöchige Verzögerung für Regressionstests zu genehmigen. |
| 3 | Wie bleiben Sie organisiert, wenn Sie ein verteiltes QA-Team leiten? | Ich verwende Azure DevOps-Boards für die Sprint-Planung, lege klare Verantwortlichkeiten in der RACI-Matrix fest und halte tägliche Stand-ups über Zeitzonen hinweg ab. |
| 4 | Welche Techniken nutzen Sie, um Junior-Tester zu betreuen? | Pair-Testing, Code-Reviews von Testskripten und regelmäßige Wissensaustausch-Sitzungen mit Fokus auf Testentwurfsmuster. |
| 5 | Wie würden Sie mit einer Situation umgehen, in der nach dem Release ein kritischer Fehler entdeckt wird? | Initiieren eines sofortigen Hot-Fix-Workflows, Durchführen einer Ursachenanalyse, Kommunizieren der Auswirkungen an die Stakeholder und Aktualisieren des Risikominderungsplans. |
| 6 | Erklären Sie Ihren Ansatz zur kontinuierlichen Verbesserung von Testprozessen. | Ich sammle Metriken (Fehler-Leakage, Testzykluszeit), führe in jedem Sprint Retrospektiven durch und implementiere inkrementelle Automatisierung, wo der ROI > 30% liegt. |
| 7 | Wie stellen Sie die Testabdeckung für neue regulatorische Anforderungen sicher? | Zuordnung jeder Regulierung zu User Stories, Erstellung von Rückverfolgbarkeitsmatrizen und Hinzufügen dedizierter Compliance-Testfälle. |
| 8 | Was ist Ihre Strategie zur Integration von Drittanbieter-APIs in die Testsuite? | Verwendung von Vertragstests (Pact), um API-Verträge zu validieren, und Mocking externer Dienste für stabile CI-Läufe. |
| 9 | Wie balancieren Sie exploratives Testen mit skriptbasierter Automatisierung? | Zuweisung von 20 % der Sprint-Kapazität für exploratives Testen zur Entdeckung, während 80 % Automatisierung für die Regressionsstabilität aufrechterhalten werden. |
| 10 | Beschreiben Sie eine Situation, in der Sie die Testgeschwindigkeit verbessert haben. | Parallelisierung des Selenium-Grids über Docker-Container, wodurch die Laufzeit der Suite von 2 Stunden auf 30 Minuten verkürzt wurde. |

## Technische & domänenspezifische Fragen

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 11 | Wie validieren Sie die Integrität der Datenmigration in Azure? | Durchführung von Prüfsummenvergleichen vor/nach der Migration, Ausführung von Datenstichprobenskripten und Überprüfung der Einhaltung von Geschäftsregeln in der Zielumgebung. |
| 12 | Welche Erfahrungen haben Sie mit Azure DevOps Test Plans? | Ich habe Test-Suiten konfiguriert, Fälle mit Anforderungen verknüpft und automatisierte Testergebnisse mithilfe der Azure Pipelines-Veröffentlichungsaufgabe generiert. |
| 13 | Wie würden Sie eine microservices-basierte Architektur testen? | Verwendung von Vertragstests für Schnittstellen, End-to-End-API-Flüsse mit Postman/Newman und Chaos Engineering zur Überprüfung der Resilienz. |
| 14 | Erklären Sie, wie Sie rollenbasierte Zugriffskontrollen (RBAC) in der Plattform testen würden. | Testbenutzer für jede Rolle erstellen, die Sichtbarkeit von UI-Elementen überprüfen und unberechtigte API-Aufrufe versuchen, bei denen 403-Antworten erwartet werden. |
| 15 | Welches Lasttest-Tool würden Sie für API-Performance wählen und warum? | k6, weil es JavaScript-Scripting verwendet, sich in CI integriert und detaillierte Latenzmetriken liefert. |
| 16 | Wie stellen Sie sicher, dass Testumgebungen über verschiedene Regionen hinweg konsistent sind? | Nutzung von Azure Resource Manager-Vorlagen zur Erstellung identischer Umgebungen und Speicherung in einem versionierten Repository. |
| 17 | Beschreiben Sie Ihren Ansatz zum Testen der Cross-Browser-Kompatibilität für ein Webportal. | Verwendung von Playwright, um Tests auf Chromium, Firefox und WebKit parallel auszuführen, was die wichtigsten Versionen und responsive Breakpoints abdeckt. |
| 18 | Wie würden Sie die Fehlerbehebung einer CI-Pipeline testen? | Einen fehlgeschlagenen Build simulieren, überprüfen, ob die Pipeline den Versuch wiederholt oder einen Rollback auslöst, und sicherstellen, dass Warnungen an den diensthabenden Techniker gesendet werden. |
| 19 | Welche Sicherheits-Testmethoden integrieren Sie für Haustiergesundheitsdaten? | OWASP ZAP-Scans, statische Codeanalyse mit SonarQube und Validierung der Verschlüsselung im Ruhezustand und bei der Übertragung gemäß ISO 27001. |
| 20 | Wie messen Sie den ROI der Testautomatisierung? | Berechnung der eingesparten manuellen Stunden gegenüber den Entwicklungskosten der Automatisierung und Verfolgung der Fehlererkennung zu einem frühen Zeitpunkt im Zyklus. |

## Zusätzliche 80 Fragen (31–110)

| # | Frage | Antwortvorschlag |
|---|-------|------------------|
| 21 | Wie gehen Sie mit instabilen Tests in der Suite um? | Ursache identifizieren, Wiederholungsversuche mit Schwellenwerten hinzufügen, Testdaten stabilisieren und hartnäckig instabile Tests unter Quarantäne stellen. |
| 22 | Wie sieht Ihr Prozess zur Versionierung von Testfällen aus? | Speichern von Testfällen in Azure DevOps mit Iterationspfaden, Kennzeichnen mit Versionsnummern und Überprüfung bei jedem Release. |
| 23 | Wie würden Sie das Disaster Recovery für Azure-Workloads testen? | Auslösen eines Failovers in die sekundäre Region, Validieren der Datenkonsistenz und Messen von RTO/RPO im Vergleich zum SLA. |
| 24 | Beschreiben Sie eine Strategie für die Entwicklung von API-Verträgen. | Verwendung semantischer Versionierung, Aufrechterhaltung abwärtskompatibler Endpunkte und Durchsetzung von Vertragstests für jede Version. |
| 25 | Wie stellen Sie die Barrierefreiheit (WCAG) in UI-Tests sicher? | Integration von axe-core in Playwright-Läufe, Fehlschlagen des Builds bei Verletzungen über dem AA-Niveau. |
| 26 | Was ist der Unterschied zwischen Smoke- und Sanity-Testing? | Smoke verifiziert die grundlegende Stabilität des Builds; Sanity validiert spezifische Funktionalitäten nach einer geringfügigen Änderung. |
| 27 | Wie würden Sie Feature Flags in der Anwendung testen? | Flags in Testumgebungen aktivieren/deaktivieren, beide Codepfade überprüfen und sicherstellen, dass beim Umschalten keine Regression auftritt. |
| 28 | Erklären Sie Ihre Methode zum Testen der Internationalisierung (i18n). | Überprüfung von UI-Strings für mehrere Regionen, Prüfung von Datums-/Zahlenformaten und Gewährleistung der Unicode-Handhabung. |
| 29 | Wie gehen Sie an das Testen geplanter Hintergrundjobs heran? | Verwendung von Time-Travel-Bibliotheken zum Auslösen von Zeitplänen, Mocking von Timern und Validieren von Job-Ergebnissen in Logs. |
| 30 | Was ist Ihr Ansatz für ein Performance-Budget? | Budgetschwellenwerte definieren (z. B. Seitenladezeit < 2 s), über Lighthouse CI durchsetzen und Builds bei Überschreitung fehlschlagen lassen. |
| 31 | Wie testen Sie die Rotation von Verschlüsselungsschlüsseln? | Schlüsselrotation simulieren, verifizieren, dass die Entschlüsselung mit neuen Schlüsseln funktioniert, und sicherstellen, dass alte Daten zugänglich bleiben. |
| 32 | Beschreiben Sie eine Methode, um die Vollständigkeit des Audit-Logs zu testen. | Aktionen im gesamten System generieren, dann die Audit-Logs für jedes Ereignis abfragen, um sicherzustellen, dass Zeitstempel und Benutzer-IDs aufgezeichnet werden. |
| 33 | Wie würden Sie die Isolation bei Mandantenfähigkeit (Multi-Tenant) testen? | Separate Mandanten-Datensätze erstellen, mandantenübergreifenden Datenzugriff versuchen und Isolationsfehler überprüfen. |
| 34 | Welchen Ansatz wählen Sie für das Testen mobiler Apps? | Verwendung von Appium für native UI-Automatisierung, Ausführung auf der BrowserStack-Gerätefarm und Verifizierung von API-Interaktionen. |
| 35 | Wie stellen Sie sicher, dass Testdaten die Produktion nicht beeinflussen? | Isolierte Testdatenbanken verwenden, Datenmaskierung anwenden und Tests niemals auf Produktionsverbindungen ausrichten. |
| 36 | Erklären Sie Ihre Verwendung von Service-Virtualisierung. | Einsatz von WireMock zur Simulation externer Dienste, was deterministische Testläufe ohne echte Abhängigkeiten ermöglicht. |
| 37 | Wie würden Sie Echtzeit-Messaging (z. B. SignalR) testen? | Test-Clients verbinden, Nachrichten veröffentlichen und Übertragungsreihenfolge sowie Latenz prüfen. |
| 38 | Was ist Ihre Strategie zur Bewältigung von Test-Flakiness aufgrund von Netzwerklatenz? | Antworten nach Möglichkeit mocken, Timeout-Schwellenwerte erhöhen und Tests in einem stabilen CI-Netzwerk ausführen. |
| 39 | Wie validieren Sie die DSGVO-Konformität in Logs? | Sicherstellen, dass Logs keine personenbezogenen Daten enthalten, Maskierung anwenden und die Einhaltung von Aufbewahrungsfristen überprüfen. |
| 40 | Beschreiben Sie eine Möglichkeit, die Sicherheit der CI-Pipeline zu testen (Abfluss von Anmeldedaten). | Scannen von Pipeline-YAMLs nach hartcodierten Geheimnissen mit git-secrets und Durchsetzung von Secrets-Scanning in PR-Prüfungen. |
| 41 | Wie würden Sie ein Upgrade eines Datenbankschemas testen? | Migrationsskripte auf einer Kopie anwenden, Integrationstests gegen das neue Schema ausführen und Abwärtskompatibilität verifizieren. |
| 42 | Was ist Ihr Prozess für die Außerbetriebnahme veralteter Testumgebungen? | Abhängigkeiten dokumentieren, Daten archivieren, Ressourcen via Terraform destroy abbauen und Dokumentation aktualisieren. |
| 43 | Wie testen Sie API-Ratenbegrenzungen (Rate Limiting)? | Senden von Anforderungsspitzen, die Limits überschreiten, Überprüfung der korrekten HTTP 429-Antworten und Überprüfung der Retry-After-Header. |
| 44 | Erklären Sie Ihren Ansatz zum Testen von CI/CD-Rollback-Mechanismen. | Einen Fehler herbeiführen, den Rollback auslösen, überprüfen, ob das vorherige Artefakt erneut bereitgestellt wird, und die Systemgesundheit validieren. |
| 45 | Wie würden Sie die Kaltstart-Performance einer Serverless-Funktion testen? | Die Funktion wiederholt aufrufen, die anfängliche Latenz messen und mit Warmstart-Metriken vergleichen. |
| 46 | Welche Tools nutzen Sie für visuelle Regressionstests? | Playwright-Screenshot-Vergleiche oder in CI integriertes Applitools Eyes. |
| 47 | Wie stellen Sie sicher, dass Testdokumentation aktuell bleibt? | Testfälle mit User Stories verknüpfen, Überprüfung im Sprint-Demo erzwingen und die Generierung der Dokumentation aus Azure DevOps automatisieren. |
| 48 | Beschreiben Sie eine Methode zum Testen von E-Mail-Benachrichtigungen. | Verwendung von Mailtrap oder eines Mock-SMTP-Servers, Erfassung gesendeter E-Mails und Validierung von Betreff-/Inhalt-Vorlagen. |
| 49 | Wie würden Sie ein Feature testen, das auf OAuth von Drittanbietern basiert? | Mocking des OAuth-Anbieters, Simulation des Token-Austauschs und Verifizierung der Token-Verarbeitung und Fehlerpfade. |
| 50 | Was ist Ihr Ansatz zum Testen von Datenpipelines in der Azure Data Factory? | Auslösen von Pipelines mit Testdatensätzen, Validieren der Ausgabe im Zielspeicher und Vergleichen von Zeilenanzahlen und Prüfsummen. |
| 51 | Wie testen Sie Pagination-APIs auf Korrektheit? | Mehrere Seiten anfordern, Gesamtzahl validieren und sicherstellen, dass keine doppelten oder fehlenden Datensätze über Seiten hinweg vorhanden sind. |
| 52 | Erklären Sie Ihre Strategie zum Testen von A/B-Experimenten. | Bereitstellen von Variantenkonfigurationen, Weiterleiten des Datenverkehrs über Feature Flags und statistische Analyse von Conversion-Metriken. |
| 53 | Wie würden Sie die Browserkompatibilität für das veraltete Internet Explorer testen? | Verwendung von Selenium mit IEDriver, Ausführung auf einer Windows-VM und Verifizierung von CSS/JS-Fallbacks. |
| 54 | Wie testen Sie Datenarchivierungsprozesse? | Archivierungsjob ausführen, dann sowohl den aktiven als auch den Archivspeicher abfragen, um sicherzustellen, dass die Daten korrekt verschoben und Indizes aktualisiert wurden. |
| 55 | Wie testen Sie Sicherheits-Header (CSP, HSTS) in Webantworten? | Verwendung von OWASP ZAP oder curl, um Antwort-Header zu erfassen und die Korrektheit von Vorhandensein/Werten zu validieren. |
| 56 | Beschreiben Sie eine Möglichkeit, die CDN-Cache-Invalidierung zu testen. | Ressource anfordern, Ursprung aktualisieren, CDN leeren, dann erneut anfordern und überprüfen, ob aktualisierte Inhalte bereitgestellt werden. |
| 57 | Wie würden Sie eine multiregionale Azure Function-Bereitstellung testen? | Bereitstellung in mehreren Regionen, Senden von Datenverkehr über Azure Front Door und Verifizierung des korrekten Routings und der Latenz. |
| 58 | Was ist Ihr Ansatz für den Rollout von Feature Toggles? | Rollout-Prozentsatz schrittweise erhöhen, Metriken überwachen und einen schnellen Rollback-Plan parat haben, falls Anomalien auftreten. |
| 59 | Wie testen Sie Datenserialisierungsformate (JSON vs. Protobuf)? | Serialisierung/Deserialisierung von Beispiel-Payloads, Validierung der Schema-Compliance und Benchmarking der Unterschiede in Größe/Latenz. |
| 60 | Erklären Sie Ihren Prozess zum Testen der API-Versionsabkündigung. | Ausführen von Tests gegen die veraltete Version, Gewährleisten korrekter Warnungen und Verifizieren der Funktionalität der neuen Version vor der Entfernung. |
| 61 | Wie würden Sie Echtzeit-Dashboards auf Datenaktualität testen? | Dateneinspeisung simulieren, sicherstellen, dass Dashboard-Aktualisierungen innerhalb des SLA (z. B. <5 Sekunden) erfolgen. |
| 62 | Was ist Ihre Strategie zum Testen von mobilen Push-Benachrichtigungen? | Verwendung des Firebase Test Labs, Erfassung des Benachrichtigungs-Payloads und Verifizierung der Verarbeitung im App-Vorder- und -Hintergrund. |
| 63 | Wie testen Sie Multi-Faktor-Authentifizierungsflüsse? | Automatisierung des OTP-Abrufs über einen Mock-Dienst, Verifizierung, dass der Login nur mit dem korrekten zweiten Faktor gelingt. |
| 64 | Beschreiben Sie eine Methode, um die Deadlock-Behandlung von Datenbanken zu testen. | Einführung konkurrierender Transaktionen, Durchsetzung korrekter Timeouts/Fehlerbehandlungen und Wiederholungslogik. |
| 65 | Wie würden Sie die SSL/TLS-Konfiguration eines Servers testen? | Ausführen eines SSL Labs-Scans, Überprüfen von Protokollversionen, Cipher Suites und Vollständigkeit der Zertifikatskette. |
| 66 | Was ist Ihr Ansatz zum Testen der Telemetrie-Datenerfassung? | Auslösen von Testereignissen, Abfragen von Application Insights und Validieren von Schema und Aufbewahrungsfrist. |
| 67 | Wie testen Sie den Zustand der Container-Orchestrierung? | Bereitstellen von Containern mit Liveness- und Readiness-Probes, Simulieren von Ausfällen und Sicherstellen, dass Kubernetes Pods neu startet. |
| 68 | Erklären Sie Ihre Strategie zum Testen von Datenexport-CSV-Dateien. | Export generieren, CSV parsen, Spaltenüberschriften, Zeilenanzahl und Datenformatierung validieren. |
| 69 | Wie würden Sie die rollenbasierte Sichtbarkeit von UI-Elementen testen? | Anmelden mit jeder Rolle, Screenshots erstellen und mit der erwarteten Liste der vorhandenen Elemente vergleichen. |
| 70 | Was ist Ihr Prozess zum Testen der API-Pagination mit einem cursorbasierten Ansatz? | Erste Seite abrufen, Cursor-Token für die nächste verwenden, Lückenlosigkeit und Freiheit von Duplikaten über Seiten hinweg verifizieren. |
| 71 | Wie testen Sie Hintergrund-Worker, die Warteschlangen verarbeiten? | Nachrichten in die Warteschlange einreihen, Logs der Worker überwachen und Verarbeitungsergebnis im Downstream-System überprüfen. |
| 72 | Beschreiben Sie eine Möglichkeit, geografische Routing-Regeln in Azure Front Door zu testen. | Verwendung von VPNs aus verschiedenen Regionen, Anfordern des Endpunkts und Verifizierung, dass der Datenverkehr in der erwarteten Region landet. |
| 73 | Wie würden Sie die PII-Maskierung in Logs testen? | Erzeugen von Logs, die PII (personenbezogene Daten) enthalten, Ausführen des Maskierungs-Utilities und Verifizieren, dass die Originaldaten nicht vorhanden sind. |
| 74 | Was ist Ihr Ansatz zum Testen von API-Drosselungsrichtlinien? | Richtlinie konfigurieren, Spitzen von Anfragen senden und korrekte Durchsetzung der Grenzwerte sowie Fehlermeldungen verifizieren. |
| 75 | Wie testen Sie die Integration mit Payment-Gateways? | Verwendung der Sandbox-Umgebung, Ausführen des End-to-End-Transaktionsflusses, Validieren von Erfolgs-/Fehler-Callbacks. |
| 76 | Erklären Sie Ihre Methode zum Testen von benutzerdefinierten Fehlerseiten (404, 500). | Ungültige URLs anfordern, korrekte Statuscodes und das Rendern benutzerdefinierter HTML-Inhalte verifizieren. |
| 77 | Wie würden Sie die Datensynchronisation zwischen Microservices testen? | Änderung in Service A auslösen, Service B abfragen und schlussendliche Konsistenz innerhalb des SLA sicherstellen. |
| 78 | Was ist Ihre Strategie zum Testen der UI für die Feature-Flag-Konfiguration? | Ändern des Flags über die Admin-UI, Verifizieren, dass der Flag-Zustand in Echtzeit an nachgelagerte Dienste übertragen wird. |
| 79 | Wie testen Sie API-Verträge auf Breaking Changes? | Ausführen von Consumer-Vertragstests gegen eine neue Anbieterversion, Erwarten von als Breaking Changes gekennzeichneten Fehlern. |
| 80 | Beschreiben Sie eine Methode zum Testen der Effizienz von CI-Pipeline-Parallelität. | Messung der Jobdauer mit und ohne parallele Jobs, Berechnung des Beschleunigungsverhältnisses und Anpassung der Ressourcenzuordnung. |

*Alle Fragen wurden für die Vorbereitung auf die Position eines Testmanagers im Unternehmen erstellt, um technische Tiefe, Führungsqualitäten und domänenspezifische Szenarien abzudecken.*
