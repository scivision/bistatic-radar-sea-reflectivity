# bistatic-sea-reflectivity
Matlab / GNU Octave NRL model of bistatic sea surface radar reflectivity for hot clutter modeling.

No special toolboxes are used, thus this should work in virtually any Matlab or GNU Octave install.


variable  |  parameter
----------|-----------
hT        | transmitter height above ground (meters)
hR        | receiver height above ground (meters)
thetad    | horizon elevation angle to transmitter (degrees)
D         | Distance between the RX and TX antennas (meters)
xPatch    | x-coordinate of the surface patch (meters)
yPatch    | y-coordinate of the surface patch (meters)
R1        | Path Length from RX to surface patch (meters)
R2        | Path Length from RX to surface patch (meters)
Rd        | Direct path length between RX and TX (meters)
grazRx  γr | Grazing angle from receiver (degrees)
grazTx  γt | Grazing angle from transmitter (degrees)


## GUI
There is a CD available on request from NRL, that has the GUI and further software. 
See the report cover page for contact info.
