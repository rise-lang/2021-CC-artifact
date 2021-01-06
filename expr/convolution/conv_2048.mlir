module {
  func @print_memref_f32(memref<*xf32>)
  func @print_time(f64, f64)
  func @rtclock() -> f64
func @conv2D(%arg0: memref<2048x2048xf32>, %arg1: memref<3x3xf32>, %arg2: memref<2048x2048xf32>) {
  "rise.lowering_unit"() ( {
    %0 = "rise.in"(%arg0) : (memref<2048x2048xf32>) -> !rise.array<2048, array<2048, scalar<f32>>>
    %1 = "rise.in"(%arg1) : (memref<3x3xf32>) -> !rise.array<3, array<3, scalar<f32>>>
    %2 = "rise.lambda"() ( {
    ^bb0(%arg3: !rise.array<2048, scalar<f32>>):  // no predecessors
      %18 = "rise.pad"() {l = #rise.nat<1>, n = #rise.nat<2048>, r = #rise.nat<1>, t = #rise.scalar<f32>} : () -> !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>
      %19 = "rise.apply"(%18, %arg3) : (!rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>, !rise.array<2048, scalar<f32>>) -> !rise.array<2050, scalar<f32>>
      "rise.return"(%19) : (!rise.array<2050, scalar<f32>>) -> ()
    }) : () -> !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>
    %3 = "rise.map"() {n = #rise.nat<2048>, s = #rise.array<2048, scalar<f32>>, t = #rise.array<2050, scalar<f32>>} : () -> !rise.fun<fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<2048, scalar<f32>>> -> array<2048, array<2050, scalar<f32>>>>>
    %4 = "rise.apply"(%3, %2, %0) : (!rise.fun<fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>> -> fun<array<2048, array<2048, scalar<f32>>> -> array<2048, array<2050, scalar<f32>>>>>, !rise.fun<array<2048, scalar<f32>> -> array<2050, scalar<f32>>>, !rise.array<2048, array<2048, scalar<f32>>>) -> !rise.array<2048, array<2050, scalar<f32>>>
    %5 = "rise.pad"() {l = #rise.nat<1>, n = #rise.nat<2048>, r = #rise.nat<1>, t = #rise.array<2050, scalar<f32>>} : () -> !rise.fun<array<2048, array<2050, scalar<f32>>> -> array<2050, array<2050, scalar<f32>>>>
    %6 = "rise.apply"(%5, %4) : (!rise.fun<array<2048, array<2050, scalar<f32>>> -> array<2050, array<2050, scalar<f32>>>>, !rise.array<2048, array<2050, scalar<f32>>>) -> !rise.array<2050, array<2050, scalar<f32>>>
    %7 = "rise.lambda"() ( {
    ^bb0(%arg3: !rise.array<2050, scalar<f32>>):  // no predecessors
      %18 = "rise.slide"() {n = #rise.nat<2048>, sp = #rise.nat<1>, sz = #rise.nat<3>, t = #rise.scalar<f32>} : () -> !rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>
      %19 = "rise.apply"(%18, %arg3) : (!rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>, !rise.array<2050, scalar<f32>>) -> !rise.array<2048, array<3, scalar<f32>>>
      "rise.return"(%19) : (!rise.array<2048, array<3, scalar<f32>>>) -> ()
    }) : () -> !rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>
    %8 = "rise.map"() {n = #rise.nat<2050>, s = #rise.array<2050, scalar<f32>>, t = #rise.array<2048, array<3, scalar<f32>>>} : () -> !rise.fun<fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>> -> fun<array<2050, array<2050, scalar<f32>>> -> array<2050, array<2048, array<3, scalar<f32>>>>>>
    %9 = "rise.apply"(%8, %7, %6) : (!rise.fun<fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>> -> fun<array<2050, array<2050, scalar<f32>>> -> array<2050, array<2048, array<3, scalar<f32>>>>>>, !rise.fun<array<2050, scalar<f32>> -> array<2048, array<3, scalar<f32>>>>, !rise.array<2050, array<2050, scalar<f32>>>) -> !rise.array<2050, array<2048, array<3, scalar<f32>>>>
    %10 = "rise.slide"() {n = #rise.nat<2048>, sp = #rise.nat<1>, sz = #rise.nat<3>, t = #rise.array<2048, array<3, scalar<f32>>>} : () -> !rise.fun<array<2050, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<2048, array<3, scalar<f32>>>>>>
    %11 = "rise.apply"(%10, %9) : (!rise.fun<array<2050, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<2048, array<3, scalar<f32>>>>>>, !rise.array<2050, array<2048, array<3, scalar<f32>>>>) -> !rise.array<2048, array<3, array<2048, array<3, scalar<f32>>>>>
    %12 = "rise.lambda"() ( {
    ^bb0(%arg3: !rise.array<3, array<2048, array<3, scalar<f32>>>>):  // no predecessors
      %18 = "rise.transpose"() {m = #rise.nat<2048>, n = #rise.nat<3>, t = #rise.array<3, scalar<f32>>} : () -> !rise.fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>>
      %19 = "rise.apply"(%18, %arg3) : (!rise.fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>>, !rise.array<3, array<2048, array<3, scalar<f32>>>>) -> !rise.array<2048, array<3, array<3, scalar<f32>>>>
      "rise.return"(%19) : (!rise.array<2048, array<3, array<3, scalar<f32>>>>) -> ()
    }) : () -> !rise.fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>>
    %13 = "rise.map"() {n = #rise.nat<2048>, s = #rise.array<3, array<2048, array<3, scalar<f32>>>>, t = #rise.array<2048, array<3, array<3, scalar<f32>>>>} : () -> !rise.fun<fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>> -> fun<array<2048, array<3, array<2048, array<3, scalar<f32>>>>> -> array<2048, array<2048, array<3, array<3, scalar<f32>>>>>>>
    %14 = "rise.apply"(%13, %12, %11) : (!rise.fun<fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>> -> fun<array<2048, array<3, array<2048, array<3, scalar<f32>>>>> -> array<2048, array<2048, array<3, array<3, scalar<f32>>>>>>>, !rise.fun<array<3, array<2048, array<3, scalar<f32>>>> -> array<2048, array<3, array<3, scalar<f32>>>>>, !rise.array<2048, array<3, array<2048, array<3, scalar<f32>>>>>) -> !rise.array<2048, array<2048, array<3, array<3, scalar<f32>>>>>
    %15 = "rise.lambda"() ( {
    ^bb0(%arg3: !rise.array<2048, array<3, array<3, scalar<f32>>>>):  // no predecessors
      %18 = "rise.lambda"() ( {
      ^bb0(%arg4: !rise.array<3, array<3, scalar<f32>>>):  // no predecessors
        %21 = "rise.zip"() {n = #rise.nat<3>, s = #rise.array<3, scalar<f32>>, t = #rise.array<3, scalar<f32>>} : () -> !rise.fun<array<3, array<3, scalar<f32>>> -> fun<array<3, array<3, scalar<f32>>> -> array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>>>>
        %22 = "rise.apply"(%21, %arg4, %1) : (!rise.fun<array<3, array<3, scalar<f32>>> -> fun<array<3, array<3, scalar<f32>>> -> array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>>>>, !rise.array<3, array<3, scalar<f32>>>, !rise.array<3, array<3, scalar<f32>>>) -> !rise.array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>>
        %23 = "rise.lambda"() ( {
        ^bb0(%arg5: !rise.tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>):  // no predecessors
          %32 = "rise.snd"() {s = #rise.array<3, scalar<f32>>, t = #rise.array<3, scalar<f32>>} : () -> !rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, scalar<f32>>>
          %33 = "rise.apply"(%32, %arg5) : (!rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, scalar<f32>>>, !rise.tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>) -> !rise.array<3, scalar<f32>>
          %34 = "rise.fst"() {s = #rise.array<3, scalar<f32>>, t = #rise.array<3, scalar<f32>>} : () -> !rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, scalar<f32>>>
          %35 = "rise.apply"(%34, %arg5) : (!rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, scalar<f32>>>, !rise.tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>) -> !rise.array<3, scalar<f32>>
          %36 = "rise.zip"() {n = #rise.nat<3>, s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>
          %37 = "rise.apply"(%36, %35, %33) : (!rise.fun<array<3, scalar<f32>> -> fun<array<3, scalar<f32>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>>, !rise.array<3, scalar<f32>>, !rise.array<3, scalar<f32>>) -> !rise.array<3, tuple<scalar<f32>, scalar<f32>>>
          "rise.return"(%37) : (!rise.array<3, tuple<scalar<f32>, scalar<f32>>>) -> ()
        }) : () -> !rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>
        %24 = "rise.map"() {n = #rise.nat<3>, s = #rise.tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>, t = #rise.array<3, tuple<scalar<f32>, scalar<f32>>>} : () -> !rise.fun<fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, tuple<scalar<f32>, scalar<f32>>>> -> fun<array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>> -> array<3, array<3, tuple<scalar<f32>, scalar<f32>>>>>>
        %25 = "rise.apply"(%24, %23, %22) : (!rise.fun<fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, tuple<scalar<f32>, scalar<f32>>>> -> fun<array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>> -> array<3, array<3, tuple<scalar<f32>, scalar<f32>>>>>>, !rise.fun<tuple<array<3, scalar<f32>>, array<3, scalar<f32>>> -> array<3, tuple<scalar<f32>, scalar<f32>>>>, !rise.array<3, tuple<array<3, scalar<f32>>, array<3, scalar<f32>>>>) -> !rise.array<3, array<3, tuple<scalar<f32>, scalar<f32>>>>
        %26 = "rise.join"() {m = #rise.nat<3>, n = #rise.nat<3>, t = #rise.tuple<scalar<f32>, scalar<f32>>} : () -> !rise.fun<array<3, array<3, tuple<scalar<f32>, scalar<f32>>>> -> array<9, tuple<scalar<f32>, scalar<f32>>>>
        %27 = "rise.apply"(%26, %25) : (!rise.fun<array<3, array<3, tuple<scalar<f32>, scalar<f32>>>> -> array<9, tuple<scalar<f32>, scalar<f32>>>>, !rise.array<3, array<3, tuple<scalar<f32>, scalar<f32>>>>) -> !rise.array<9, tuple<scalar<f32>, scalar<f32>>>
        %28 = "rise.literal"() {literal = #rise.lit<0.000000, scalar<f32>>} : () -> !rise.scalar<f32>
        %29 = "rise.lambda"() ( {
        ^bb0(%arg5: !rise.tuple<scalar<f32>, scalar<f32>>, %arg6: !rise.scalar<f32>):  // no predecessors
          %32 = "rise.fst"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %33 = "rise.apply"(%32, %arg5) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %34 = "rise.snd"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
          %35 = "rise.apply"(%34, %arg5) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
          %36 = "rise.embed"(%33, %35, %arg6) ( {
          ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):  // no predecessors
            %37 = mulf %arg7, %arg8 : f32
            %38 = addf %arg9, %37 : f32
            "rise.return"(%38) : (f32) -> ()
          }) : (!rise.scalar<f32>, !rise.scalar<f32>, !rise.scalar<f32>) -> !rise.scalar<f32>
          "rise.return"(%36) : (!rise.scalar<f32>) -> ()
        }) : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>
        %30 = "rise.reduceSeq"() {n = #rise.nat<9>, s = #rise.tuple<scalar<f32>, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<9, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>
        %31 = "rise.apply"(%30, %29, %28, %27) : (!rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<9, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>, !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>, !rise.scalar<f32>, !rise.array<9, tuple<scalar<f32>, scalar<f32>>>) -> !rise.scalar<f32>
        "rise.return"(%31) : (!rise.scalar<f32>) -> ()
      }) : () -> !rise.fun<array<3, array<3, scalar<f32>>> -> scalar<f32>>
      %19 = "rise.mapSeq"() {n = #rise.nat<2048>, s = #rise.array<3, array<3, scalar<f32>>>, t = #rise.scalar<f32>, to = "scf"} : () -> !rise.fun<fun<array<3, array<3, scalar<f32>>> -> scalar<f32>> -> fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>>>
      %20 = "rise.apply"(%19, %18, %arg3) : (!rise.fun<fun<array<3, array<3, scalar<f32>>> -> scalar<f32>> -> fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>>>, !rise.fun<array<3, array<3, scalar<f32>>> -> scalar<f32>>, !rise.array<2048, array<3, array<3, scalar<f32>>>>) -> !rise.array<2048, scalar<f32>>
      "rise.return"(%20) : (!rise.array<2048, scalar<f32>>) -> ()
    }) : () -> !rise.fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>>
    %16 = "rise.mapSeq"() {n = #rise.nat<2048>, s = #rise.array<2048, array<3, array<3, scalar<f32>>>>, t = #rise.array<2048, scalar<f32>>, to = "scf"} : () -> !rise.fun<fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>> -> fun<array<2048, array<2048, array<3, array<3, scalar<f32>>>>> -> array<2048, array<2048, scalar<f32>>>>>
    %17 = "rise.apply"(%16, %15, %14) : (!rise.fun<fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>> -> fun<array<2048, array<2048, array<3, array<3, scalar<f32>>>>> -> array<2048, array<2048, scalar<f32>>>>>, !rise.fun<array<2048, array<3, array<3, scalar<f32>>>> -> array<2048, scalar<f32>>>, !rise.array<2048, array<2048, array<3, array<3, scalar<f32>>>>>) -> !rise.array<2048, array<2048, scalar<f32>>>
    "rise.out"(%arg2, %17) : (memref<2048x2048xf32>, !rise.array<2048, array<2048, scalar<f32>>>) -> ()
    "rise.return"() : () -> ()
  }) : () -> ()
  return
}func @conv2D_test() {
  %c0 = constant 0 : index
  %c3 = constant 3 : index
  %c1 = constant 1 : index
  %c0_0 = constant 0 : index
  %c3_1 = constant 3 : index
  %c1_2 = constant 1 : index
  %cst = constant 1.000000e+00 : f32
  %0 = alloc() : memref<3x3xf32>
  scf.for %arg0 = %c0 to %c3 step %c1 {
    scf.for %arg1 = %c0_0 to %c3_1 step %c1_2 {
      store %cst, %0[%arg0, %arg1] : memref<3x3xf32>
    }
  }
  %c0_3 = constant 0 : index
  %c2048 = constant 2048 : index
  %c1_4 = constant 1 : index
  %c0_5 = constant 0 : index
  %c2048_6 = constant 2048 : index
  %c1_7 = constant 1 : index
  %cst_8 = constant 0.000000e+00 : f32
  %cst_9 = constant 1.000000e+00 : f32
  %c300 = constant 100 : index
  %1 = alloc() : memref<f32>
  store %cst_8, %1[] : memref<f32>
  %2 = alloc() : memref<2048x2048xf32>
  scf.for %arg0 = %c0_3 to %c2048 step %c1_4 {
    scf.for %arg1 = %c0_5 to %c2048_6 step %c1_7 {
      %7 = load %1[] : memref<f32>
      store %7, %2[%arg0, %arg1] : memref<2048x2048xf32>
      %8 = load %1[] : memref<f32>
      %9 = addf %8, %cst_9 : f32
      store %9, %1[] : memref<f32>
    }
  }
  %3 = alloc() : memref<2048x2048xf32>
  scf.for %arg0 = %c0 to %c300 step %c1 {
    %t1 = call @rtclock() : () -> f64
    call @conv2D(%2, %0, %3) : (memref<2048x2048xf32>, memref<3x3xf32>, memref<2048x2048xf32>) -> ()
    %t2 = call @rtclock() : () -> f64
    call @print_time(%t1, %t2) : (f64, f64) -> ()
  }
  %4 = memref_cast %2 : memref<2048x2048xf32> to memref<*xf32>
  call @print_memref_f32(%4) : (memref<*xf32>) -> ()
  %5 = memref_cast %0 : memref<3x3xf32> to memref<*xf32>
  call @print_memref_f32(%5) : (memref<*xf32>) -> ()
  %6 = memref_cast %3 : memref<2048x2048xf32> to memref<*xf32>
  call @print_memref_f32(%6) : (memref<*xf32>) -> ()
  return
}
  func @main() {
    call @conv2D_test() : () -> ()
    return
  }
}