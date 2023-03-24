# DMDD_PROJECT

<h1>Project Topic: Art gallery management system</h1>
<h2>Team Members</h2>
<ul>
<li>Ramya Devie Saravana bhava - saravanabhava.r@northeastern.edu - 002770163</li>
<li>Yuktaba Gohil - gohil.y@northeastern.edu - 002786959</li>
<li>Divyasree Gandikota - gandikota.d@northeastern.edu - 002743837</li>
<li>Ghanashyam Vibhandik - vibhandik.g@northeastern.edu - 002984660</li>
<li>Sravani Marturu - marturu.s@northeastern.edu - 002990728</li>
</ul>

<h2>1.   OVERVIEW</h2>
<p>Art gallery management system is a software application designed for managing the art gallery. It provides a centralized database for storing artworks, conducting exhibitions, and performing sales. The system can be used to track the inventory and manage customer relationships. This application connects artists and art lovers where the artists display their artwork (in digital format) and customers can choose to buy from various art types such as paintings, sculptures, digital art, photography, drawings, ceramics, etc.  

Artists can register online with the art gallery to become a member and upload their artworks in digital format. Our online application provides customers/art lovers the comfort of enjoying art from anywhere. It also exposes international arts and artists to art lovers. Exhibitions can be held online where the artists can exhibit their artworks and people can buy the artwork. Art lovers can buy the artwork from the gallery via online transaction and from anywhere in the world.</p>

<h2>2.   PROBLEM STATEMENT </h2>
<p>Offline art gallery management has space limitations and will be limited to artists and location which curbs the artist’s exposure. An online platform can overcome this issue where art lovers can browse the arts in their own time from the comfort of anywhere in the world. It also exposes the art enthusiasts to diverse kinds of art and international artists.</p>

<h2>3.   OBJECTIVES</h2>
<ul>
<li>Our application provides a centralized platform for diverse kinds of artists around the world to connect with their admirers.</li>
<li>To promote artists and their work internationally.</li>
<li>Our application will help art lovers visit exhibitions online and familiarize artists around the world.</li>
<li>To help build the art community.</li>
<li>Online art gallery that can manage all the art sales and purchases.</li>
<li>It will help to overcome the manual errors and make a computerized system.</li>
</ul>
 
<h2>Business Rules:</h2>
<ul>
<li>Each user should be registered member of the online art gallery</li>
<li>Each user can have only one of the three user roles (Admin, Artist, Customer)</li>
<li>Each user can have one to many contact details (mobile number, address)</li>
<li>Each user of the type ‘Artist’ can have one to many artwork</li>
<li>Every artwork will be a part of only one art category</li>
<li>Each art category may have zero to many artworks</li>
<li>Each user of the type ‘Artist’ may have zero to many online exhibitions</li>
<li>Each exhibition can have one or more artworks</li>
<li>One exhibition can display only one artist's artworks</li>
<li>There can be zero or many exhibitions happening in the same date and time</li>
<li>Each user of type ‘Customer’ may place zero or many orders</li>
<li>Each user of type ‘Customer’ can visit zero or many exhibitions</li>
<li>Each order can have one or many artwork</li>
<li>Each artwork can be associated with only one order</li>
<li>Once order is placed by a customer, it cannot be cancelled</li>
<li>Each shipper will have zero or many orders to be shipped</li>
</ul>

<h4>Instructions to run the script:</h2>
<ul>
<li>Initially run the USERGRANT.sql file in Admin – This allows the admin to create the user and grant accesses to the user</li>
<li>Now run the PROJECT3.sql file under the user created – Use the credentials given by admin in USERGRANT.sql to login as the user </li>
</ul>