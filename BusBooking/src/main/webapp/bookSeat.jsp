<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Passenger Details</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

    <form method="post">
        <h2>Passenger Details</h2>
        <label for="name">Passenger Name:</label>
        <input type="text" id="name" name="name"><br><br>

        <label for="age">Age:</label>
        <input type="number" id="age" name="age"  min="2" ><br><br>

        <label for="mobile">Mobile Number:</label>
        <input type="tel" id="mobile" name="mobile" pattern="[0-9]{10}"><br><br>

        <label for="address">Address:</label>
        <input type="text" id="address" name="address" ><br><br>
        
        <button type="submit">Submit</button>
    </form>
</body>
</html>
