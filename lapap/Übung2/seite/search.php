<?php
include('header.php');
?>
<?php include_once('nav.php') ?>
<article id="welcome">
    <p> <h1>Willkommen auf der Suchseite für die Arztpraxis</h1></p>
</article>
<div class="container mt-5">
    <h2>Patienten abfragen</h2>
    <form action="" method="get">
        <div class="form-group">
            <label for="search">Suche nach Vorname oder Nachname:</label>
            <input type="text" class="form-control" id="search" name="search" required>
        </div>
        <button type="submit" class="btn btn-primary">Suchen</button>
    </form>

    <?php
    try {
        include('connect_database.php');
         if (isset($_GET['search'])) {
            // Suchparameter abrufen
            $search = '%' . $_GET['search'] . '%';

            // Prepared Statement für sichere Abfrage
            $stmt = $conn->prepare("
                SELECT p.*, s.stadt,s.plz, l.land
                FROM patienten p
                JOIN staedte s ON p.stadt_id = s.stadt_id
                JOIN laender l ON s.land_id = l.land_id
                WHERE p.vorname LIKE :search
                OR p.nachname LIKE :search"
            );
            $stmt->bindParam(':search', $search);
            $stmt->execute();

            if ($stmt->rowCount() > 0) {
                echo "<h3>Gefundene Patienten:</h3>";
                echo "<div class='table-responsive'>";
                echo "<table class='table table-bordered'>";
                echo "<thead class='thead-dark'>";
                echo "<tr>";
                echo "<th>Vorname</th>";
                echo "<th>Nachname</th>";
                echo "<th>Geburtsdatum</th>";
                echo "<th>PLZ</th>";
                echo "<th>Stadt</th>";
                echo "<th>Land</th>";
                echo "</tr>";
                echo "</thead>";
                echo "<tbody>";
                while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                    echo "<tr>";
                    echo "<td>{$row['vorname']}</td>";
                    echo "<td>{$row['nachname']}</td>";
                    echo "<td>{$row['geburtsdatum']}</td>";
                    echo "<td>{$row['plz']}</td>";
                    echo "<td>{$row['stadt']}</td>";
                    echo "<td>{$row['land']}</td>";
                    echo "</tr>";
                }
                echo "</tbody>";
                echo "</table>";
                echo "</div>";
            } else {
                echo "<div class='alert alert-info mt-3'>Keine Patienten gefunden.</div>";
            }
        }
    } catch (PDOException $e) {
        echo "<div class='alert alert-danger mt-3'>Datenbankfehler: " . $e->getMessage() . "</div>";
    }
    finally{
        $conn = null;
    }
    ?>
</div>
<?php include('footer.php') ?>