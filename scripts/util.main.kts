import java.io.File
import java.io.IOException
import java.util.concurrent.TimeUnit

import kotlin.system.exitProcess

object Utils {
    /**
     * Attempts to get a value for an argument by getting the
     * value at next index in [arguments]. Exits if unable to get the
     * value or argument hasn't been supplied. Call this function
     * only if a value is supposed to be passed along with the argument.
     *
     * @param arg the argument for which the value should be obtained.
     *
     * @return the value for the argument.
     */
    fun getArgValue(arg: String, arguments: Array<String>): String {
        assertArgExists(arg, arguments)
        val index = arguments.indexOf(arg)
        if (arguments.size == (index + 1)) {
            Log.fatal("Argument $arg does not have any supplied value")
            exitProcess(1)
        }
        return arguments[index + 1]
    }

    /**
     * Attempts to get all whitespace separated values for an arg in [arguments]
     * until the next argument or until the last value. Exits if argument
     * hasn't been supplied.
     *
     * @param arg the argument for which the values should be obtained.
     *
     * @return a [List] of all the values passes for the argument.
     */
    fun getArgValues(arg: String, arguments: Array<String>): List<String> {
        assertArgExists(arg, arguments)
        val values = mutableListOf<String>()
        for (i in (arguments.indexOf(arg) + 1) until arguments.size) {
            val value = arguments[i]
            if (value.startsWith("-")) { // Stop if the value is the next argument
                break
            }
            values.add(value)
        }
        return values.toList()
    }

    /**
     * Assert that an argument has been supplied.
     *
     * @param arg the argument to check for.
     */
    private fun assertArgExists(arg: String, arguments: Array<String>) {
        if (!arguments.contains(arg)) {
            Log.fatal("Argument $arg not supplied")
            exitProcess(1)
        }
    }

    /**
     * Prompts the user and returns input value.
     *
     * @param prompt the message to display in console.
     * @param inputFilter a [List] of accepted inputs, if null then input value is returned no matter what.
     *        If not, this function is recursively called until a valid input is entered.
     * @param defaultOnEnter whether to return null if enter key is pressed
     */
    fun inputPrompt(prompt: String, inputFilter: List<String>? = null, defaultOnEnter: Boolean = false): String? {
        println(prompt)
        val input = readLine()
        if (defaultOnEnter && input?.isBlank() != false) return null
        if (inputFilter?.isNotEmpty() == true) {
            if (!inputFilter.contains(input)) {
                val acceptedInputs = inputFilter.fold("") { r, t -> if (r.isBlank()) "$r$t" else "$r,$t" }
                println("Invalid input, accepted inputs are: $acceptedInputs")
                return inputPrompt(prompt, inputFilter)
            }
        }
        return input
    }
}

object ShellUtils {
    /**
     * Wrapper function to run a shell command
     *
     * @param commands the list of commands to pass to the [ProcessBuilder] constructor
     * @param dir the working directory in which this command should be run
     * @param timeout time in millis to wait until the process should be killed.
     *                Defaults to 10 minutes.
     *
     * @return an [Output] which contains the exit status of the command and output / error message as well
     */
    fun run(commands: List<String>, dir: String? = null, timeout: Long = TimeUnit.MINUTES.toMillis(10)): Output {
        try {
            val process = ProcessBuilder(commands)
                .redirectOutput(ProcessBuilder.Redirect.PIPE)
                .redirectError(ProcessBuilder.Redirect.PIPE).also {
                    if (dir != null) it.directory(File(dir))
                }.start().also {
                    it.waitFor(timeout, TimeUnit.MILLISECONDS)
                }
            return Output(
                process.exitValue(),
                process.inputStream.bufferedReader().use { it.readText() },
                process.errorStream.bufferedReader().use { it.readText() },
            )
        } catch (e: IOException) {
            Log.fatal("${e.message}")
            exitProcess(1)
        }
    }

    /**
     * An overloaded version of the function below where @param cmd is a single command to run
     * which will be split into a list based on \\s (whitespace).
     */
    fun run(cmd: String, dir: String? = null, timeout: Long = TimeUnit.MINUTES.toMillis(10)): Output {
        return run(cmd.split("\\s".toRegex()), dir, timeout)
    }
}

/**
 * A data class representing the output of a process
 */
data class Output(
    val exitCode: Int,
    val output: String?,
    val error: String?
)

/**
 * Utility object for logging messages to console
 */
object Log {
    fun info(msg: String?) {
        println("Info: $msg")
    }

    fun warn(msg: String?) {
        println("Warning: $msg")
    }

    fun error(msg: String?) {
        println("Error: $msg")
    }

    fun fatal(msg: String?) {
        println("Fatal error: $msg")
    }
}