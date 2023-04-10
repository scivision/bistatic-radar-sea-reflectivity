# Matlab Bistatic Sea Reflectivity model

[Original NRL Paper](./a610697.pdf) by Rashmi Mital and Vilhelm Gregers-Hansen

Matlab NRL model of bistatic sea surface radar reflectivity for
hot clutter modeling.

No Matlab toolboxes are used.

  variable   | description
-------------|--------------------------------------------------
  hT         | transmitter height above ground (meters)
  hR         | receiver height above ground (meters)
  thetad     | horizon elevation angle to transmitter (degrees)
  D          | Distance between the RX and TX antennas (meters)
  xPatch     | x-coordinate of the surface patch (meters)
  yPatch     | y-coordinate of the surface patch (meters)
  R1         | Path Length from RX to surface patch (meters)
  R2         | Path Length from RX to surface patch (meters)
  Rd         | Direct path length between RX and TX (meters)
  grazRx:γr  | Grazing angle from receiver (degrees)
  grazTx:γt  | Grazing angle from transmitter (degrees)
