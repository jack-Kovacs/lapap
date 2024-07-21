<?php
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <p> <h1>Willkommen auf der Einfügeseite für die Arztpraxis</h1></p>
</article>
<div class="container">

    <!-- Formular zum Einfügen eines neuen Patienten -->
    <div class="container mt-5">
    <h2>Patienten hinzufügen</h2>
    <form action="" method="post">
        <div class="form-group">
            <label for="vorname">Vorname</label>
            <input type="text" class="form-control" id="vorname" name="vorname" required>
        </div>
        <div class="form-group">
            <label for="nachname">Nachname</label>
            <input type="text" class="form-control" id="nachname" name="nachname" required>
        </div>
        <div class="form-group">
            <label for="geburtsdatum">Geburtsdatum</label>
            <input type="date" class="form-control" id="geburtsdatum" name="geburtsdatum" required>
        </div>
        <div class="form-group">
            <label for="strasse">Straße</label>
            <input type="text" class="form-control" id="strasse" name="strasse" required>
        </div>
        <div class="form-group">
            <label for="hausnummer">Hausnummer</label>
            <input type="text" class="form-control" id="hausnummer" name="hausnummer" required>
        </div>
        <div class="form-group">
            <label for="stadt_id">Stadt</label>
            <select class="form-control" id="stadt_id" name="stadt_id" required>
                <?php
                // Verbindungsaufbau zur Datenbank
                try {
                    $pdo = new PDO('mysql:host=localhost;dbname=arztpraxis', 'root', '');
                    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                    $stmt = $pdo->query("SELECT stadt_id, stadt, plz FROM staedte");
                    while ($row = $stmt->fetch()) {
                        echo "<option value='{$row['stadt_id']}'>{$row['stadt']} ({$row['plz']})</option>";
                    }
                } catch (PDOException $e) {
                    echo "Datenbankfehler: " . $e->getMessage();
                }
                ?>
            </select>
        </div>
        <div class="form-group">
            <label for="telefon">Telefon</label>
            <input type="text" class="form-control" id="telefon" name="telefon">
        </div>
        <button type="submit" class="btn btn-primary">Hinzufügen</button>
    </form>

    <?php
    if ($_SERVER['REQUEST_METHOD'] === 'POST') {
        // Formulardaten abrufen
        $vorname = $_POST['vorname'];
        $nachname = $_POST['nachname'];
        $geburtsdatum = $_POST['geburtsdatum'];
        $strasse = $_POST['strasse'];
        $hausnummer = $_POST['hausnummer'];
        $stadt_id = $_POST['stadt_id'];
        $telefon = $_POST['telefon'];

        try {
            // Prepared Statement für sicheren Insert
            $stmt = $pdo->prepare("
                INSERT INTO patienten (
                    vorname, nachname, geburtsdatum, strasse, hausnummer, stadt_id, telefon
                ) VALUES (
                    :vorname, :nachname, :geburtsdatum, :strasse, :hausnummer, :stadt_id, :telefon
                )
            ");
            $stmt->bindParam(':vorname', $vorname);
            $stmt->bindParam(':nachname', $nachname);
            $stmt->bindParam(':geburtsdatum', $geburtsdatum);
            $stmt->bindParam(':strasse', $strasse);
            $stmt->bindParam(':hausnummer', $hausnummer);
            $stmt->bindParam(':stadt_id', $stadt_id);
            $stmt->bindParam(':telefon', $telefon);

            if ($stmt->execute()) {
                echo "<div class='alert alert-success mt-3'>Patient erfolgreich hinzugefügt.</div>";
            } else {
                echo "<div class='alert alert-danger mt-3'>Fehler beim Hinzufügen des Patienten.</div>";
            }
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Fehler: " . $e->getMessage() . "</div>";
        }
    }
    ?>
    </div>
</div>
<?php include('footer.php') ?>