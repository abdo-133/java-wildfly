# Base Image 
FROM quay.io/wildfly/wildfly:latest-jdk17
Run /opt/jboss/wildfly/bin/add-user.sh admin Admin#123 --silent 

# Copy War file 
Copy target/hello-wildfly-1.0.war /opt/jboss/wildfly/standalone/deployments/

# Expose ports 
Expose 8080 9990

#Run The Application 
CMD ["/opt/jboss/wildfly/bin/standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]
