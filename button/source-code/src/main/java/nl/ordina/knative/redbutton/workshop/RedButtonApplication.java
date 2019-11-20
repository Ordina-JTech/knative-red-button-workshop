package nl.ordina.knative.redbutton.workshop;

import org.jnativehook.GlobalScreen;

import java.util.logging.Logger;

import static java.util.logging.Level.WARNING;
import static java.util.logging.Logger.getLogger;

public class RedButtonApplication {

    public static void main(final String[] args) {
        disableFrameworkLogging();
        Script script = new Script(args.length == 1 ? args[0] : null);
        new ButtonPressListener(script).register();
    }

    private static void disableFrameworkLogging() {
        Logger logger = getLogger(GlobalScreen.class.getPackage().getName());
        logger.setLevel(WARNING);
        logger.setUseParentHandlers(false);
    }
}
