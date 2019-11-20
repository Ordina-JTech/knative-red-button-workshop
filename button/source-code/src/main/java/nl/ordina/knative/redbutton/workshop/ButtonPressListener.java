package nl.ordina.knative.redbutton.workshop;

import org.jnativehook.GlobalScreen;
import org.jnativehook.NativeHookException;
import org.jnativehook.keyboard.NativeKeyEvent;
import org.jnativehook.keyboard.NativeKeyListener;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import static org.jnativehook.keyboard.NativeKeyEvent.*;

public class ButtonPressListener implements NativeKeyListener {
    private static final Logger logger = LoggerFactory.getLogger(ButtonPressListener.class);

    private int count;
    private int expectedKey = VC_CONTROL;
    private long timestampFirstKeyPress;

    private final long maximumTimeToTrigger = 2000;
    private final long minTimeBetweenExecutions = 10000;
    private final long escapeTimeLimit = 5000;

    private long escapeTime;
    private long lastExecution;

    private boolean escapePressed;

    private Script script;

    public ButtonPressListener(Script script) {
        this.script = script;
    }

    public void register() {
        try {
            GlobalScreen.registerNativeHook();
        } catch (final NativeHookException e) {
            logger.error(e.getMessage(), e);
            System.exit(-1);
        }

        GlobalScreen.addNativeKeyListener(this);
    }

    @Override
    public void nativeKeyPressed(final NativeKeyEvent event) {
        if (isKey(event, VC_ESCAPE)) {
            logger.info("Escape pressed - press button within " + this.escapeTimeLimit + " milliseconds to terminate the process");
            this.escapePressed = true;
            this.escapeTime = now();

        } else if (isKey(event, VC_CONTROL) && wasExpecting(VC_CONTROL)) {
            logger.debug("Ctrl pressed");
            this.expectedKey = VC_SHIFT;
            evaluate();

        } else if (isKey(event, VC_SHIFT) && wasExpecting(VC_SHIFT)) {
            logger.debug("Shift pressed");
            this.expectedKey = VC_CONTROL;
            evaluate();

        } else {
            _reset();
        }
    }

    private boolean wasExpecting(int expectedKey) {
        return this.expectedKey == expectedKey;
    }

    private boolean isKey(NativeKeyEvent e, int expectedKeyCode) {
        return (expectedKeyCode == e.getKeyCode());
    }

    @Override
    public void nativeKeyReleased(final NativeKeyEvent e) {
        logger.debug("released: " + e.getKeyCode());
    }

    @Override
    public void nativeKeyTyped(final NativeKeyEvent e) {
        logger.debug("typed: " + e.getKeyCode());
    }

    private void evaluate() {
        if (this.count == 0) {
            this.count += 1;
            this.timestampFirstKeyPress = now();
        } else if ((this.count == 9) && (elapsedTimeMillis(this.timestampFirstKeyPress) < this.maximumTimeToTrigger)) {
            _reset();
            _execute();
        } else if (elapsedTimeMillis(this.timestampFirstKeyPress) > this.maximumTimeToTrigger) {
            logger.info("too slow...");
            _reset();
        } else {
            this.count += 1;
        }
    }

    private long now() {
        return System.currentTimeMillis();
    }

    private long elapsedTimeMillis(final long startTime) {
        return now() - startTime;
    }

    private void _reset() {
        this.expectedKey = VC_CONTROL;
        this.count = 0;
    }

    private void _execute() {
        if (inCooldownPeriod()) {
            this.lastExecution = now();

            if (this.escapePressed && (elapsedTimeMillis(this.escapeTime) < this.escapeTimeLimit)) {
                logger.info("Escape mode entered, shutdown process");
                try {
                    GlobalScreen.unregisterNativeHook();
                } catch (final NativeHookException e) {
                    logger.error(e.getMessage(), e);
                    System.exit(-1);
                }
            } else {
                String message = "Deployment script execution";
                logger.info(message + " triggered...");
                int exitCode = script.run();
                if (exitCode != 0) {
                    logger.error(message + " [FAILED] with exitCode: {}", exitCode);
                    System.exit(exitCode);
                }
                logger.info(message + " [SUCCESS]");
            }
        } else {
            logger.info("You have to wait " + this.minTimeBetweenExecutions + " milliseconds between button presses");
        }
    }

    private boolean inCooldownPeriod() {
        return (now() - this.lastExecution) > this.minTimeBetweenExecutions;
    }

    private boolean _checkKeyPress(final int keyPress, final int keyCode) {
        return (keyCode == keyPress);
    }

    private boolean _checkKeyPress(final int keyPress, final int keyCode, final int nextKey) {
        return _checkKeyPress(keyPress, keyCode) && _checkKeyPress(nextKey, this.expectedKey);
    }
}
