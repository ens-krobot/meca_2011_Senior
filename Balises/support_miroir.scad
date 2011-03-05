
dim_base = 30.; // Taille de la base
dim_miroir = 25.; // Taille du miroir
ep_miroir = 2.; // Épaisseur du miroir

D_min = 150.; // Distance minimale d'approche
D_max = 4000.; // Distance maximale

d_balise = 100.; // Décalage du bas de la balise par rapport au miroir
h_balise = 80.; // Hauteur de la balise

// Calculs
h_min = d_balise;
h_max = d_balise + h_balise;
theta_min = atan(h_min / D_max);
theta_max = atan(h_max / D_min);
theta = (theta_min + theta_max)/2.;

echo("Angle minimal du faisceau sortant");
echo(theta_min);
echo("Angle maximal du faisceau sortant");
echo(theta_max);

phi = 45. + theta / 2.;
echo("Angle du miroir par rapport à l'horizontale");
echo(phi);

// Pièce
difference() {
    // Base
    scale(dim_base)
        linear_extrude(height=1, center=false)
        polygon(points=[[0, 0], [0, tan(phi)], [1, 0]], paths = [[0, 1, 2]]);

    // Support miroir
    #translate([dim_base / 2., dim_base * tan(phi)/2., dim_base / 2.])
        rotate([0, 0, 90. - phi])
        cube([ep_miroir, dim_miroir, dim_miroir], center=true);
}

