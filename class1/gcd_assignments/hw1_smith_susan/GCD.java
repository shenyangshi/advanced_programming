/*******************************************************************************
 * Name          : GCD.java
 * Author        : Susan Smith
 * Version       : 1.0
 * Date          : September 7, 2022
 * Last modified : September 12, 2022
 * Description   : Computes the GCD of two command-line arguments.
 ******************************************************************************/
public class GCD {
    /**
     * Iteratively computes the greatest common divisor of two integers
     * using Euclid's algorithm.
     * @param m  the first integer
     * @param n  the second integer
     * @return gcd(m, n)
     */
    public static int iterativeGcd(int m, int n) {
        while (n != 0) {
            int r = m % n;
            m = n;
            n = r;
        }
        return m;
    }

    /**
     * Recursively computes the greatest common divisor of two integers
     * using Euclid's algorithm.
     * @param m  the first integer
     * @param n  the second integer
     * @return gcd(m, n)
     */
    public static int recursiveGcd(int m, int n) {
        return n == 0 ? m : recursiveGcd(n, m % n);
    }

    /**
     * Computes the greatest common divisor of two integers provided as
     * parameters to the program.
     */
    public static void main(String[] args) {
        if (args.length != 2) {
            System.err.println("Usage: java GCD <integer m> <integer n>");
            System.exit(1);
        }

        int m = 0, n = 0;
        try {
            m = Integer.parseInt(args[0]);
        } catch (NumberFormatException nfe) {
            System.err.println("Error: The first argument is not a valid integer.");
            System.exit(1);
        }

        try {
            n = Integer.parseInt(args[1]);
        } catch (NumberFormatException nfe) {
            System.err.println("Error: The second argument is not a valid integer.");
            System.exit(1);
        }

        if (m == 0 && n == 0) {
            // System.out.println("gcd(0, 0) = undefined");
        } else {
            // Don't forget that gcd(m, n) = gcd(|m|, |n|). So, we should never return
            // a negative value.
            int absM = Math.abs(m), absN = Math.abs(n);
            System.out.println("Iterative: gcd(" + m + ", " + n + ") = " + iterativeGcd(absM, absN));
            System.out.println("Recursive: gcd(" + m + ", " + n + ") = " + recursiveGcd(absM, absN));
        }
        System.exit(0);
    }
}
