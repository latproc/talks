This directory contains source code for the genslide program
in the scripts directory above. Genslides takes a slide file
and transform is:

* lines that start with # are comments
* lines that begin in column one and are not comments
   mark the beginning of a slide
* lines that begin in column one are formatted as an <h2>
* lines that have text after the first tab are formatted
   as <p> elements
* lines that begin with two tabs are formatted as <li> elements 
   within a <ul> block
* lines that begin with three tabs are formatted as <li> elements 
   within a <ul> block that is nested inside another <ul>
* lines that begin with <tab>-- are formatted as speaker
   notes (<aside> elements)
* speaker notes lines are merged together until a different
   type of line (eg a blank line) is detected
