image-resizer
=============

Web service that takes a url, height, and width parameter to resize an image. Supported file types are: bmp, png, jpeg, jpg, tiff, png, tga

Requires ImageMagick to be installed prior to installation.

Usage:
To download the resized image
\<host url\>/resizer/download?url=\<image url\>&height=\<new height\>&width=\<new width\>

To view the resized image in the browser
\<host url\>/resizer/display?url=\<image url\>&height=\<new height\>&width=\<new width\>

Live @ Heroku
You can view this application at http://ajohnson-image-resizer.herokuapp.com/

Example: http://ajohnson-image-resizer.herokuapp.com/display/?url=http://i.imgur.com/KLxTM.jpg&height=500&width=500