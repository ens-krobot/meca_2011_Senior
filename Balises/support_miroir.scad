
$fs = 0.1;
$fa = 5;
epsilon = 0.1;

dim_base = 30.; // Taille de la base
dim_miroir = 25.; // Taille du miroir
ep_miroir = 2.; // paisseur du miroir
diam_trou = 7.; // Diamtre du trou
diam_vis = 3.1; // Diamtre du trou
ep_fond = 3.5; // paisseur du fond du trou
dist_trous = 18.3; // Distance entre les trous
// distance extrieure 21mm
// diamtre trous 2.7mm

//D_min = 150.; // Distance minimale d'approche
//D_max = 4000.; // Distance maximale
D_min = 370.; // Distance minimale d'approche
D_max = 1200.; // Distance maximale

d_balise = 40.; // Dcalage du bas de la balise par rapport au miroir
h_balise = 80.; // Hauteur de la balise

// Calculs
h_min = d_balise;
h_max = d_balise + h_balise;
theta_min = atan(h_min / D_min);
theta_max = atan(h_max / D_max);
theta = 60;

echo("Angle minimal du faisceau sortant");
echo(theta_min);
echo("Angle maximal du faisceau sortant");
echo(theta_max);

phi = 42.3;
echo("Angle du miroir par rapport  l'horizontale");
echo(phi);

module trou() {
    translate([0, 0, ep_fond]) cylinder(r=diam_trou/2., h=500);
    translate([0, 0, -epsilon]) cylinder(r=diam_vis/2., h=500);
}


h_base = 25;
// Pice
translate([0, 0, h_base]) rotate([90, 0, 0]) difference() {
    // Base
    union(){
    scale(dim_base)
        linear_extrude(height=1, center=false)
        polygon(points=[[0, 0], [0, tan(phi)], [1, 0]], paths = [[0, 1, 2]]);
    
    translate([0,-h_base,0])
      cube([dim_base, h_base,dim_base]);
    }
    // Support miroir
    #translate([dim_base / 2., dim_base * tan(phi)/2., dim_base / 2.])
        rotate([0, 0, 90. - phi])
        cube([ep_miroir, dim_miroir, dim_miroir], center=true);

    translate([dim_base/2., -h_base, dim_base/2. - dist_trous/2.]) rotate([-90, 0, 0]) trou();

    translate([dim_base/2., -h_base, dim_base/2. + dist_trous/2.]) rotate([-90, 0, 0]) trou();
}

h_tot = h_base + dim_base*tan(phi);
echo("Hauteur totale");
echo(h_tot);



