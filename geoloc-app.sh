#!/bin/bash

mkdir tempdir
mkdir tempdir/templates
mkdir tempdir/static

cp geoloc.py tempdir/.
cp -r templates/* tempdir/templates/.
cp -r static/* tempdir/static/.

echo "FROM python" > tempdir/Dockerfile
echo "RUN pip install flask" >> tempdir/Dockerfile
echo "RUN pip install ipapi" >> tempdir/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> tempdir/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> tempdir/Dockerfile
echo "COPY  geoloc.py /home/myapp/" >> tempdir/Dockerfile
echo "EXPOSE 5050" >> tempdir/Dockerfile
echo "CMD python3 /home/myapp/geoloc.py" >> tempdir/Dockerfile

cd tempdir
docker build -t geolocapp .
docker run -t -d -p 5050:5050 --name geolocrunning geolocapp
docker ps -a