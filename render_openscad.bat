@ECHO OFF

SET PAGES_PATH=..\gh-pages\descentmarkers

ECHO Generating images
openscad.exe -o img\part-all.png -D "part=""all""" --render DescentMarkers.scad
openscad.exe -o img\part-grave.png -D "part=""grave""" --render DescentMarkers.scad
openscad.exe -o img\part-altar.png -D "part=""altar""" --render DescentMarkers.scad

ECHO Generating STL files
openscad.exe -o stl\part-all.stl -D "part=""all""" --render DescentMarkers.scad
openscad.exe -o stl\part-grave.stl -D "part=""grave""" --render DescentMarkers.scad
openscad.exe -o stl\part-altar.stl -D "part=""altar""" --render DescentMarkers.scad

ECHO Updating Pages
COPY img\part-grave.png %PAGES_PATH%\images\descentmarkers.png
COPY stl\part-grave.stl %PAGES_PATH%\stl\descentmarkers.stl
