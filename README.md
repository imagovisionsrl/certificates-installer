# CertInstall Tool

## Descrizione

`CertInstall Tool` è uno script batch per installare certificati `.der` nelle Trusted Root Certification Authorities e nelle Intermediate Certification Authorities di Windows. Questo script � particolarmente utile per automatizzare l'aggiunta di certificati in ambienti gestiti o per la distribuzione in massa.

## Prerequisiti

- **Privilegi di Amministratore**: Lo script deve essere eseguito con privilegi di amministratore. Senza i diritti necessari, lo script non procederà e mostrerà un messaggio di errore.
- **Certificati**: Assicurati di avere i certificati in formato `.der` organizzati in due cartelle:
  - `root`: Per i certificati da aggiungere alle **Trusted Root Certification Authorities**.
  - `intermediate`: Per i certificati da aggiungere alle **Intermediate Certification Authorities**.

## Struttura delle Cartelle

Organizza i certificati nelle seguenti cartelle:

```
CertInstallTool/
|
+-- CertInstall.bat  # Script batch per l'installazione dei certificati
|
+-- root/            # Certificati per Trusted Root CA
|   +-- isrg-root-x1.der
|   +-- isrg-root-x2.der
|   +-- ...          # Altri certificati root
|
+-- intermediate/    # Certificati per Intermediate CA
    +-- e5.der
    +-- e6.der
    +-- ...          # Altri certificati intermedi
```

## Come Utilizzare

1. **Preparazione**:
   - Posiziona i certificati `.der` nelle rispettive cartelle `root` e `intermediate`.

2. **Esecuzione dello Script**:
   - Esegui il file `CertInstall.bat` con privilegi di amministratore.
   - Per fare ciò, fai clic destro sul file `CertInstall.bat` e seleziona "Esegui come amministratore".

3. **Output Atteso**:
   - Lo script installerà i certificati e mostrerà un messaggio `OK` per ogni certificato installato con successo.
   - In caso di errore, verrà mostrato l'output di `certmgr.exe` per diagnosticare il problema.

## Output dello Script

Esempio di output quando lo script viene eseguito correttamente:

```
=====================[ ROOT CA ]=====================

Installing: isrg-root-x2.der... OK
Installing: isrgrootx1.der... OK

Completed

==================[ INTERMEDIATE CA ]================

Installing: e5.der... OK
Installing: e6.der... OK
Installing: r10.der... OK
Installing: r11.der... OK

Completed

=================[ PROCESS COMPLETE ]=================
```

## Risoluzione dei Problemi

- **Permessi Insufficienti**:
  - Se lo script viene eseguito senza privilegi di amministratore, vedrai questo errore:
    ```
    [ERROR] Questo script deve essere eseguito con privilegi di amministratore.
    Fare clic con il tasto destro sul file e selezionare "Esegui come amministratore".
    ```
  - Soluzione: Esegui lo script con privilegi di amministratore.

- **Errori durante l'installazione**:
  - Se un certificato non viene installato correttamente, lo script mostrer� l'errore specifico prodotto da `certmgr.exe`.
  - Soluzione: Leggi l'output dell'errore per diagnosticare e risolvere il problema. Assicurati che il certificato sia valido e che il formato sia corretto.

## Licenza

Questo script è distribuito sotto la [MIT License](LICENSE). Sentiti libero di usarlo e modificarlo secondo le tue esigenze.