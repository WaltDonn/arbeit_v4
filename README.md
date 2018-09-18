docker build -t arbeit_4 .

Run TTY: docker run -p 8080:80 -t arbeit_4

Run Background: docker run -p 8059:80 -d arbeit_4


Stop all: docker stop $(docker ps -aq)
Kill all: docker rm $(docker ps -aq)