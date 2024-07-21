<?php
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <p> <h1>Willkommen auf der Einfügeseite für die Arztpraxis</h1></p>
</article>
<div class="container mt-5">
    <h2>Neue Stadt hinzufügen</h2>
    <form action="" method="post">
        <div class="form-group">
            <label for="stadt">Stadt:</label>
            <input type="text" class="form-control" id="stadt" name="stadt" required>
        </div>
        <div class="form-group">
            <label for="plz">PLZ:</label>
            <input type="text" class="form-control" id="plz" name="plz" required>
        </div>
        <div class="form-group">
            <label for="land">Land:</label>
            <select class="form-control" id="land" name="land" required>
                <option value="">Bitte auswählen</option>
                <?php
                // Verbindungsaufbau zur Datenbank
                try {
                    $pdo = new PDO('mysql:host=localhost;dbname=arztpraxis', 'root', '');
                    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

                    // Abfrage der Länder aus der Datenbank
                    $stmt = $pdo->query("SELECT * FROM laender");
                    while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                        echo "<option value='{$row['land_id']}'>{$row['land']}</option>";
                    }
                } catch (PDOException $e) {
                    echo "<option value=''>Fehler beim Laden der Länder</option>";
                }
                ?>
            </select>
        </div>
        <button type="submit" class="btn btn-primary">Stadt hinzufügen</button>
    </form>

    <?php
    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        try {
            $pdo = new PDO('mysql:host=localhost;dbname=arztpraxis', 'root', '');
            $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);

            $stadt = $_POST['stadt'];
            $plz = $_POST['plz'];
            $land_id = $_POST['land'];

            $stmt = $pdo->prepare("INSERT INTO staedte (stadt, plz, land_id) VALUES (:stadt, :plz, :land_id)");
            $stmt->bindParam(':stadt', $stadt);
            $stmt->bindParam(':plz', $plz);
            $stmt->bindParam(':land_id', $land_id);
            $stmt->execute();

            echo "<div class='alert alert-success mt-3'>Stadt wurde erfolgreich hinzugefügt.</div>";
        } catch (PDOException $e) {
            echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
        }
    }
    ?>
</div>
<?php include('footer.php') ?>