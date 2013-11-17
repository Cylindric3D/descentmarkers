@ECHO OFF

SET PAGES_PATH=..\gh-pages\descentmarkers

ECHO Generating images
openscad.exe -o img\part-grave.png -D "part=""grave""" --render DescentMarkers.scad

ECHO Generating STL files
openscad.exe -o stl\part-grave.stl -D "part=""grave""" -D --render DescentMarkers.scad

ECHO Updating Pages
COPY img\part-grave.png %PAGES_PATH%\images\descentmarkers.png
COPY stl\part-grave.stl %PAGES_PATH%\stl\descentmarkers.stl
