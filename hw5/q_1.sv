module factorial_function;
  function int factorial(int n);
    if (n <= 1)
      return 1;
    else
      return n * factorial(n - 1);
  endfunction

  // Test the factorial function
  initial begin
    int input = 5;
    int result = factorial(input);
    $display("Factorial of %0d is %0d", input, result);
  end
endmodule

