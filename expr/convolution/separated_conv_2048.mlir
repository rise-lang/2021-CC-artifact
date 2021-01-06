module {
  func @print_memref_f32(memref<*xf32>)
  func @print_time(f64, f64)
  func @rtclock() -> f64
func @conv2DSeparable(%arg0: memref<2048x2048xf32>, %arg1: memref<3xf32>, %arg2: memref<3xf32>, %arg3: memref<2048x2048xf32>) {
  "rise.lowering_unit"() ( {
    %0 = "rise.in"(%arg0) : (memref<2048x2048xf32>) -> !rise.array<2048, array<2048, scalar<f32>>>
    %1 = "rise.in"(%arg1) : (memref<3xf32>) -> !rise.array<3, scalar<f32>>
    %2 = "rise.in"(%arg2) : (memref<3xf32>) -> !rise.array<3, scalar<f32>>
    %3 = "rise.lambda"() ( {
    ^bb0(%arg4: !rise.array<2048, scalar<f32>>):  // no predecessors
      %16 = "rise.pad"() {l = #rise.nat<1>, n = #rise.nat<2048>, r = #rise.nat<1>, t = #rise.scalar<f32>} : () -> !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>
      %17 = "rise.apply"(%16, %arg4) : (!rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>, !rise.array<2048, scalar<f32>>) -> !rise.array<2050, scalar<f32>>
      "rise.return"(%17) : (!rise.array<2050, scalar<f32>>) -> ()
    }) : () -> !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>
    %4 = "rise.map"() {n = #rise.nat<2048>, s = #rise.array<2048, scalar<f32>>, t = #rise.array<2050, scalar<f32>>} : () -> !rise.fun<fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<2048, scalar<f32>>> -> array<2048, array<2050, scalar<f32>>>>>
    %5 = "rise.apply"(%4, %3, %0) : (!rise.fun<fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<2048, scalar<f32>>> -> array<2048, array<2050, scalar<f32>>>>>, !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>, !rise.array<2048, array<2048, scalar<f32>>>) -> !rise.array<2048, array<2050, scalar<f32>>>
    %6 = "rise.pad"() {l = #rise.nat<1>, n = #rise.nat<2048>, r = #rise.nat<1>, t = #rise.array<2050, scalar<f32>>} : () -> !rise.fun<array<2048, array<2050, scalar<f32>>> -> array<2050, array<2050, scalar<f32>>>>
    %7 = "rise.apply"(%6, %5) : (!rise.fun<array<2048, array<2050, scalar<f32>>> -> array<2050, array<2050, scalar<f32>>>>, !rise.array<2048, array<2050, scalar<f32>>>) -> !rise.array<2050, array<2050, scalar<f32>>>
    %8 = "rise.slide"() {n = #rise.nat<2048>, sp = #rise.nat<1>, sz = #rise.nat<3>, t = #rise.array<2050, scalar<f32>>} : () -> !rise.fun<array<2050, array<2050, scalar<f32>>> -> array<2048, array<3, array<2050, scalar<f32>>>>>
    %9 = "rise.apply"(%8, %7) : (!rise.fun<array<2050, array<2050, scalar<f32>>> -> array<2048, array<3, array<2050, scalar<f32>>>>>, !rise.array<2050, array<2050, scalar<f32>>>) -> !rise.array<2048, array<3, array<2050, scalar<f32>>>>
    %10 = "rise.lambda"() ( {
    ^bb0(%arg4: !rise.array<3, array<2050, scalar<f32>>>):  // no predecessors
      %16 = "rise.transpose"() {m = #rise.nat<2050>, n = #rise.nat<3>, t = #rise.scalar<f32>} : () -> !rise.fun<array<3, array<2050, scalar<f32>>> -> array<2050, array<3, scalar<f32>>>>
      %17 = "rise.apply"(%16, %arg4) : (!rise.fun<array<3, array<2050, scalar<f32>>> -> array<2050, array<3, scalar<f32>>>>, !rise.array<3, array<2050, scalar<f32>>>) -> !rise.array<2050, array<3, scalar<f32>>>
      %18 = "rise.lambda"() ( {
      ^bb0(%arg5: !rise.array<3, scalar<f32>>):  // no predecessors
        %21 = "rise.zip"() {n = #rise.nat<3>, s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>
        %22 = "rise.apply"(%21, %arg5, %2) : (!rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>, !rise.array<3, scalar<f32>>, !rise.array<3, scalar<f32>>) -> !rise.array<3, tuple<scalar<f32>, scalar<f32>>>
        %23 = "rise.literal"() {literal = #rise.lit<0.000000, scalar<f32>>} : () -> !rise.scalar<f32>
        %24 = "rise.lambda"() ( {
        ^bb0(%arg6: !rise.tuple<scalar<f32>, scalar<f32>>, %arg7: !rise.scalar<f32>):  // no predecessors
          %27 = "rise.fst"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %28 = "rise.apply"(%27, %arg6) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %29 = "rise.snd"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %30 = "rise.apply"(%29, %arg6) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %31 = "rise.embed"(%28, %30, %arg7) ( {
          ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):  // no predecessors
            %32 = mulf %arg8, %arg9 : f32
            %33 = addf %arg10, %32 : f32
            "rise.return"(%33) : (f32) -> ()
          }) : (!rise.scalar<f32>, !rise.scalar<f32>, !rise.scalar<f32>) -> !rise.scalar<f32>
          "rise.return"(%31) : (!rise.scalar<f32>) -> ()
        }) : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>
        %25 = "rise.reduceSeq"() {n = #rise.nat<3>, s = #rise.tuple<scalar<f32>, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<3, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>
        %26 = "rise.apply"(%25, %24, %23, %22) : (!rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<3, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>, !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>, !rise.scalar<f32>, !rise.array<3, tuple<scalar<f32>, scalar<f32>>>) -> !rise.scalar<f32>
        "rise.return"(%26) : (!rise.scalar<f32>) -> ()
      }) : () -> !rise.fun<array<3, scalar<f32>> -> scalar<f32>>
      %19 = "rise.mapSeq"() {n = #rise.nat<2050>, s = #rise.array<3, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<array<3, scalar<f32>> -> scalar<f32>> -> fun<array<2050, array<3, scalar<f32>>> -> array<2050, scalar<f32>>>>
      %20 = "rise.apply"(%19, %18, %17) : (!rise.fun<fun<array<3, scalar<f32>> -> scalar<f32>> -> fun<array<2050, array<3, scalar<f32>>> -> array<2050, scalar<f32>>>>, !rise.fun<array<3, scalar<f32>> -> scalar<f32>>, !rise.array<2050, array<3, scalar<f32>>>) -> !rise.array<2050, scalar<f32>>
      "rise.return"(%20) : (!rise.array<2050, scalar<f32>>) -> ()
    }) : () -> !rise.fun<array<3, array<2050, scalar<f32>>> -> array<2050, scalar<f32>>>
    %11 = "rise.mapSeq"() {n = #rise.nat<2048>, s = #rise.array<3, array<2050, scalar<f32>>>, t = #rise.array<2050, scalar<f32>>, to = "affine"} : () -> !rise.fun<fun<array<3, array<2050, scalar<f32>>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<3, array<2050, scalar<f32>>>> -> array<2048, array<2050, scalar<f32>>>>>
    %12 = "rise.apply"(%11, %10, %9) : (!rise.fun<fun<array<3, array<2050, scalar<f32>>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<3, array<2050, scalar<f32>>>> -> array<2048, array<2050, scalar<f32>>>>>, !rise.fun<array<3, array<2050, scalar<f32>>> -> array<2050, scalar<f32>>>, !rise.array<2048, array<3, array<2050, scalar<f32>>>>) -> !rise.array<2048, array<2050, scalar<f32>>>
    %13 = "rise.lambda"() ( {
    ^bb0(%arg4: !rise.array<2050, scalar<f32>>):  // no predecessors
      %16 = "rise.slide"() {n = #rise.nat<2048>, sp = #rise.nat<1>, sz = #rise.nat<3>, t = #rise.scalar<f32>} : () -> !rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>
      %17 = "rise.apply"(%16, %arg4) : (!rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>, !rise.array<2050, scalar<f32>>) -> !rise.array<2048, array<3, scalar<f32>>>
      %18 = "rise.lambda"() ( {
      ^bb0(%arg5: !rise.array<3, scalar<f32>>):  // no predecessors
        %21 = "rise.zip"() {n = #rise.nat<3>, s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>
        %22 = "rise.apply"(%21, %arg5, %1) : (!rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>, !rise.array<3, scalar<f32>>, !rise.array<3, scalar<f32>>) -> !rise.array<3, tuple<scalar<f32>, scalar<f32>>>
        %23 = "rise.literal"() {literal = #rise.lit<0.000000, scalar<f32>>} : () -> !rise.scalar<f32>
        %24 = "rise.lambda"() ( {
        ^bb0(%arg6: !rise.tuple<scalar<f32>, scalar<f32>>, %arg7: !rise.scalar<f32>):  // no predecessors
          %27 = "rise.fst"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %28 = "rise.apply"(%27, %arg6) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %29 = "rise.snd"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %30 = "rise.apply"(%29, %arg6) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %31 = "rise.embed"(%28, %30, %arg7) ( {
          ^bb0(%arg8: f32, %arg9: f32, %arg10: f32):  // no predecessors
            %32 = mulf %arg8, %arg9 : f32
            %33 = addf %arg10, %32 : f32
            "rise.return"(%33) : (f32) -> ()
          }) : (!rise.scalar<f32>, !rise.scalar<f32>, !rise.scalar<f32>) -> !rise.scalar<f32>
          "rise.return"(%31) : (!rise.scalar<f32>) -> ()
        }) : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>
        %25 = "rise.reduceSeq"() {n = #rise.nat<3>, s = #rise.tuple<scalar<f32>, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<3, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>
        %26 = "rise.apply"(%25, %24, %23, %22) : (!rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<3, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>, !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>, !rise.scalar<f32>, !rise.array<3, tuple<scalar<f32>, scalar<f32>>>) -> !rise.scalar<f32>
        "rise.return"(%26) : (!rise.scalar<f32>) -> ()
      }) : () -> !rise.fun<array<3, scalar<f32>> -> scalar<f32>>
      %19 = "rise.mapSeq"() {n = #rise.nat<2048>, s = #rise.array<3, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<array<3, scalar<f32>> -> scalar<f32>> -> fun<array<2048, array<3, scalar<f32>>> -> array<2048, scalar<f32>>>>
      %20 = "rise.apply"(%19, %18, %17) : (!rise.fun<fun<array<3, scalar<f32>> -> scalar<f32>> -> fun<array<2048, array<3, scalar<f32>>> -> array<2048, scalar<f32>>>>, !rise.fun<array<3, scalar<f32>> -> scalar<f32>>, !rise.array<2048, array<3, scalar<f32>>>) -> !rise.array<2048, scalar<f32>>
      "rise.return"(%20) : (!rise.array<2048, scalar<f32>>) -> ()
    }) : () -> !rise.fun<array<2050, scalar<f32>> -> array<2048, scalar<f32>>>
    %14 = "rise.mapSeq"() {n = #rise.nat<2048>, s = #rise.array<2050, scalar<f32>>, t = #rise.array<2048, scalar<f32>>, to = "affine"} : () -> !rise.fun<fun<array<2050, scalar<f32>> -> array<2048, scalar<f32>>> -> fun<array<2048, array<2050, scalar<f32>>> -> array<2048, array<2048, scalar<f32>>>>>
    %15 = "rise.apply"(%14, %13, %12) : (!rise.fun<fun<array<2050, scalar<f32>> -> array<2048, scalar<f32>>> -> fun<array<2048, array<2050, scalar<f32>>> -> array<2048, array<2048, scalar<f32>>>>>, !rise.fun<array<2050, scalar<f32>> -> array<2048, scalar<f32>>>, !rise.array<2048, array<2050, scalar<f32>>>) -> !rise.array<2048, array<2048, scalar<f32>>>
    "rise.out"(%arg3, %15) : (memref<2048x2048xf32>, !rise.array<2048, array<2048, scalar<f32>>>) -> ()
    "rise.return"() : () -> ()
  }) : () -> ()
  return
}func @conv2DSeparable_test() {
  %c0 = constant 0 : index
  %c3 = constant 3 : index
  %c1 = constant 1 : index
  %cst = constant 1.000000e+00 : f32
  %0 = alloc() : memref<3xf32>
  scf.for %arg0 = %c0 to %c3 step %c1 {
    store %cst, %0[%arg0] : memref<3xf32>
  }
  %c0_0 = constant 0 : index
  %c3_1 = constant 3 : index
  %c1_2 = constant 1 : index
  %cst_3 = constant 1.000000e+00 : f32
  %1 = alloc() : memref<3xf32>
  scf.for %arg0 = %c0_0 to %c3_1 step %c1_2 {
    store %cst_3, %1[%arg0] : memref<3xf32>
  }
  %c0_4 = constant 0 : index
  %c2048 = constant 2048 : index
  %c1_5 = constant 1 : index
  %c0_6 = constant 0 : index
  %c2048_7 = constant 2048 : index
  %c1_8 = constant 1 : index
  %cst_9 = constant 0.000000e+00 : f32
  %cst_10 = constant 1.000000e+00 : f32
  %c300 = constant 100 : index
  %2 = alloc() : memref<f32>
  store %cst_9, %2[] : memref<f32>
  %3 = alloc() : memref<2048x2048xf32>
  scf.for %arg0 = %c0_4 to %c2048 step %c1_5 {
    scf.for %arg1 = %c0_6 to %c2048_7 step %c1_8 {
      %9 = load %2[] : memref<f32>
      store %9, %3[%arg0, %arg1] : memref<2048x2048xf32>
      %10 = load %2[] : memref<f32>
      %11 = addf %10, %cst_10 : f32
      store %11, %2[] : memref<f32>
    }
  }
  %4 = alloc() : memref<2048x2048xf32>
  scf.for %arg0 = %c0 to %c300 step %c1 {
    %t1 = call @rtclock() : () -> f64
    call @conv2DSeparable(%3, %1, %0, %4) : (memref<2048x2048xf32>, memref<3xf32>, memref<3xf32>, memref<2048x2048xf32>) -> ()
    %t2 = call @rtclock() : () -> f64
    call @print_time(%t1, %t2) : (f64, f64) -> ()
  }
  %5 = memref_cast %3 : memref<2048x2048xf32> to memref<*xf32>
  call @print_memref_f32(%5) : (memref<*xf32>) -> ()
  %6 = memref_cast %1 : memref<3xf32> to memref<*xf32>
  call @print_memref_f32(%6) : (memref<*xf32>) -> ()
  %7 = memref_cast %0 : memref<3xf32> to memref<*xf32>
  call @print_memref_f32(%7) : (memref<*xf32>) -> ()
  %8 = memref_cast %4 : memref<2048x2048xf32> to memref<*xf32>
  call @print_memref_f32(%8) : (memref<*xf32>) -> ()
  return
}
  func @main() {
    call @conv2DSeparable_test() : () -> ()
    return
  }
}