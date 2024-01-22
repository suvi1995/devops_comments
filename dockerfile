dockerfile
  instruction:arugumrnt
  FROM centos:6
  RUN sudo apt-get update  >>>> to run cmd
  RUN sudo apt-get install apache  -y
  CMD apachectl -D FOREGROUND >> to start server
  LABEL <key:value>
  for example
    LABLE "e-comerence": "development"
  EXPOSE <lisner port no>
  EXPOSE 80
  ADD >>>> copy and exraxt the file 
  COPY >>> only copy the file 
  RUN >>> comment run into ur OS
  RUN sudo apt install git -y
  if u forget to give yes(-y) then it will get error
  RUN sudo apt update && sudo apt install git -y
  CMD 
  ENTRYPOINT
  VOLUME >> mount the exrta volume
  USER>>>if u want
  WORKDIR>> used to set the working directory
  ENV  >>>to set enviornment variable.  we will see that varible name after
  ARG
    
