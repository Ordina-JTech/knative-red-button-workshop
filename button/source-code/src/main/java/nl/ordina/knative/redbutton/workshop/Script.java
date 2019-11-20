package nl.ordina.knative.redbutton.workshop;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.File;
import java.io.IOException;
import java.net.URISyntaxException;
import java.security.CodeSource;

class Script {
    private static final Logger logger = LoggerFactory.getLogger(Script.class);
    private String location;

    Script(String location) {
        if(location == null || location.isEmpty()){
            location = getDefaultScript();
        }
        this.location = location;
    }

    int run() {
        ProcessBuilder builder = new ProcessBuilder("bash", "container-execute.sh");
        builder.inheritIO();
        builder.directory(new File(location));
        try {
            Process process = builder.start();
            while (process.isAlive()) {
                int pollInMillis = 2000;
                logger.info("process is running, waiting to finish... next poll in {} ms", pollInMillis);
                Thread.sleep(pollInMillis);
            }
            return process.exitValue();
        } catch (IOException | InterruptedException e) {
            e.printStackTrace();
            return -1;
        }
    }

    private static String getDefaultScript() {
        try {
            CodeSource codeSource = Script.class.getProtectionDomain().getCodeSource();
            File jarFile = new File(codeSource.getLocation().toURI().getPath());
            File currentDirectory = jarFile.getParentFile();
            logger.info("Running in directory: " + currentDirectory.getPath());

            return currentDirectory.getParentFile().getPath();
        } catch (URISyntaxException e) {
            throw new RuntimeException(e);
        }
    }
}
