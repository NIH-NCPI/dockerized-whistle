# dockerized-whistle
Docker image for google's Whistle FHIR ingest language

[Whistle](https://github.com/GoogleCloudPlatform/healthcare-data-harmonization) is google's Data Transformation Language which can be used to transform arbitrary JSON objects into FHIR compliant JSON objects. This repository contains a single docker image suitable to produce a fully functional whistle image and a shell script to make it behave like the actual application would without having to provide the various arguments required for docker to find and call the image. 
