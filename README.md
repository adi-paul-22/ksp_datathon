# COMPSTATS

Welcome to Compstats, the app which helps you to better analyse performance of the police and allocate resources more efficiently

## Getting Started
## Flutter application set up
To where you copy the code, write 
```bash
cd ksp_datathon
```
This will move you into the working directory
To set up flutter,
```bash
flutter pub get
```

## Server set up
First inside ksp_datathon, move into the server folder to start our servers

### api_server.py
To start api_server.py,
```bash
uvicorn api_server:app --reload
```
### Node server,
First we need to install certain node modules 
For this write this command
```bash
npm install
```

To start the node server, write
```bash
node server
```
# Application Architecture
![](assets/images/architecture.jpeg)

This explains a complex architecture of our application. We are using Flutter because it is a cross platform language and thus a single code can maintain and work in web and phone. For Data Visualization, We are using Power BI for getting insights about the data maintained by the Police. Lets break it into two parts for simplification - The web app and The Mobile App.