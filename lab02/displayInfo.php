
<?php

    if(isset($_POST['submit'])){

        
        $orderNumber = $_POST['number'];
        $size = $_POST['size'];
        $color = $_POST['color'];
        $extra_item = array($_POST['extra_item']);
        $first_name = $_POST['first_name'];
        $last_name = $_POST['last_name'];
        $address1 = $_POST['address1'];
        $address2 = $_POST['address2'];
        $address3 = $_POST['address3'];
        $comments = $_POST['comments'];

        echo "<h1>Your Information System</h1>";

        echo "Thank you, $first_name for your perches from our web site <br><br>";
        echo "your item colour is: $color & T-Shirt size: $size<br><br>";
        echo "Selected items/item are:<br><br>";
        foreach ($_POST['extra_item'] as $selected){
            echo "*$selected<br>";
        }
        echo "<br>";
        echo "your items will be sent to: <br><br>";
        echo "$first_name $last_name,<br>$address1<br>$address2<br>$address3<br><br>";
        echo "Thank you for submitting your comments. We appreciate it. You said:<br><br>$comments";
    

    }
?>