module {
  func @print_memref_f32(memref<*xf32>)
  func @print_f32(f32)
  func @print_bin_op(f32, f32, f32)
  func @print_time(f64, f64)
  func @rtclock() -> f64
  func @mm(%arg0: memref<1x784xf32>, %arg1: memref<784x128xf32>, %arg2: memref<1x128xf32>) {
    "rise.lowering_unit"() ( {
      %0 = "rise.in"(%arg0) : (memref<1x784xf32>) -> !rise.array<1, array<784, scalar<f32>>>
      %1 = "rise.in"(%arg1) : (memref<784x128xf32>) -> !rise.array<784, array<128, scalar<f32>>>
      %2 = "rise.lambda"() ( {
      ^bb0(%arg3: !rise.array<784, scalar<f32>>):  // no predecessors
        %5 = "rise.transpose"() {m = #rise.nat<128>, n = #rise.nat<784>, t = #rise.scalar<f32>} : () -> !rise.fun<array<784, array<128, scalar<f32>>> -> array<128, array<784, scalar<f32>>>>
        %6 = "rise.apply"(%5, %1) : (!rise.fun<array<784, array<128, scalar<f32>>> -> array<128, array<784, scalar<f32>>>>, !rise.array<784, array<128, scalar<f32>>>) -> !rise.array<128, array<784, scalar<f32>>>
        %7 = "rise.lambda"() ( {
        ^bb0(%arg4: !rise.array<784, scalar<f32>>):  // no predecessors
          %10 = "rise.zip"() {n = #rise.nat<784>, s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<array<784, scalar<f32>> -> fun<array<784, scalar<f32>> -> array<784, tuple<scalar<f32>, scalar<f32>>>>>
          %11 = "rise.apply"(%10, %arg3, %arg4) : (!rise.fun<array<784, scalar<f32>> -> fun<array<784, scalar<f32>> -> array<784, tuple<scalar<f32>, scalar<f32>>>>>, !rise.array<784, scalar<f32>>, !rise.array<784, scalar<f32>>) -> !rise.array<784, tuple<scalar<f32>, scalar<f32>>>
          %12 = "rise.literal"() {literal = #rise.lit<0.000000, scalar<f32>>} : () -> !rise.scalar<f32>
          %13 = "rise.lambda"() ( {
          ^bb0(%arg5: !rise.tuple<scalar<f32>, scalar<f32>>, %arg6: !rise.scalar<f32>):  // no predecessors
            %16 = "rise.fst"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
            %17 = "rise.apply"(%16, %arg5) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
            %18 = "rise.snd"() {s = #rise.scalar<f32>, t = #rise.scalar<f32>} : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>
            %19 = "rise.apply"(%18, %arg5) : (!rise.fun<tuple<scalar<f32>, scalar<f32>> -> scalar<f32>>, !rise.tuple<scalar<f32>, scalar<f32>>) -> !rise.scalar<f32>
            %20 = "rise.embed"(%17, %19, %arg6) ( {
            ^bb0(%arg7: f32, %arg8: f32, %arg9: f32):  // no predecessors
              %21 = mulf %arg7, %arg8 : f32
              %22 = addf %arg9, %21 : f32
              "rise.return"(%22) : (f32) -> ()
            }) : (!rise.scalar<f32>, !rise.scalar<f32>, !rise.scalar<f32>) -> !rise.scalar<f32>
            "rise.return"(%20) : (!rise.scalar<f32>) -> ()
          }) : () -> !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>
          %14 = "rise.reduceSeq"() {n = #rise.nat<784>, s = #rise.tuple<scalar<f32>, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<784, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>
          %15 = "rise.apply"(%14, %13, %12, %11) : (!rise.fun<fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>> -> fun<scalar<f32> -> fun<array<784, tuple<scalar<f32>, scalar<f32>>> -> scalar<f32>>>>, !rise.fun<tuple<scalar<f32>, scalar<f32>> -> fun<scalar<f32> -> scalar<f32>>>, !rise.scalar<f32>, !rise.array<784, tuple<scalar<f32>, scalar<f32>>>) -> !rise.scalar<f32>
          "rise.return"(%15) : (!rise.scalar<f32>) -> ()
        }) : () -> !rise.fun<array<784, scalar<f32>> -> scalar<f32>>
        %8 = "rise.mapSeq"() {n = #rise.nat<128>, s = #rise.array<784, scalar<f32>>, t = #rise.scalar<f32>, to = "affine"} : () -> !rise.fun<fun<array<784, scalar<f32>> -> scalar<f32>> -> fun<array<128, array<784, scalar<f32>>> -> array<128, scalar<f32>>>>
        %9 = "rise.apply"(%8, %7, %6) : (!rise.fun<fun<array<784, scalar<f32>> -> scalar<f32>> -> fun<array<128, array<784, scalar<f32>>> -> array<128, scalar<f32>>>>, !rise.fun<array<784, scalar<f32>> -> scalar<f32>>, !rise.array<128, array<784, scalar<f32>>>) -> !rise.array<128, scalar<f32>>
        "rise.return"(%9) : (!rise.array<128, scalar<f32>>) -> ()
      }) : () -> !rise.fun<array<784, scalar<f32>> -> array<128, scalar<f32>>>
      %3 = "rise.mapSeq"() {n = #rise.nat<1>, s = #rise.array<784, scalar<f32>>, t = #rise.array<128, scalar<f32>>, to = "affine"} : () -> !rise.fun<fun<array<784, scalar<f32>> -> array<128, scalar<f32>>> -> fun<array<1, array<784, scalar<f32>>> -> array<1, array<128, scalar<f32>>>>>
      %4 = "rise.apply"(%3, %2, %0) : (!rise.fun<fun<array<784, scalar<f32>> -> array<128, scalar<f32>>> -> fun<array<1, array<784, scalar<f32>>> -> array<1, array<128, scalar<f32>>>>>, !rise.fun<array<784, scalar<f32>> -> array<128, scalar<f32>>>, !rise.array<1, array<784, scalar<f32>>>) -> !rise.array<1, array<128, scalar<f32>>>
      "rise.out"(%arg2, %4) : (memref<1x128xf32>, !rise.array<1, array<128, scalar<f32>>>) -> ()
      "rise.return"() : () -> ()
    }) : () -> ()
    return
  }
  func @main() {
    call @mm_test() : () -> ()
    return
  }
  func @mm_test() {
    %c128 = constant 128 : index
    %c784 = constant 784 : index
    %cst = constant 0.000000e+00 : f32
    %cst_0 = constant 1.000000e+00 : f32
    %c0 = constant 0 : index
    %c1 = constant 1 : index
    %c300 = constant 100 : index
    %0 = alloc() : memref<f32>
    store %cst, %0[] : memref<f32>
    %1 = alloc() : memref<784x128xf32>
    scf.for %arg0 = %c0 to %c784 step %c1 {
      scf.for %arg1 = %c0 to %c128 step %c1 {
        %8 = load %0[] : memref<f32>
        store %8, %1[%arg0, %arg1] : memref<784x128xf32>
        %9 = load %0[] : memref<f32>
        %10 = addf %9, %cst_0 : f32
        store %10, %0[] : memref<f32>
      }
    }
    %2 = alloc() : memref<f32>
    store %cst, %2[] : memref<f32>
    %3 = alloc() : memref<1x784xf32>
    scf.for %arg0 = %c0 to %c1 step %c1 {
      scf.for %arg1 = %c0 to %c784 step %c1 {
        %8 = load %2[] : memref<f32>
        store %8, %3[%arg0, %arg1] : memref<1x784xf32>
        %9 = load %2[] : memref<f32>
        %10 = addf %9, %cst_0 : f32
        store %10, %2[] : memref<f32>
      }
    }
    %4 = alloc() : memref<1x128xf32>
    scf.for %arg0 = %c0 to %c300 step %c1 {
      %8 = call @rtclock() : () -> f64
      call @mm(%3, %1, %4) : (memref<1x784xf32>, memref<784x128xf32>, memref<1x128xf32>) -> ()
      %9 = call @rtclock() : () -> f64
      call @print_time(%8, %9) : (f64, f64) -> ()
    }
    %5 = memref_cast %3 : memref<1x784xf32> to memref<*xf32>
    call @print_memref_f32(%5) : (memref<*xf32>) -> ()
    %6 = memref_cast %1 : memref<784x128xf32> to memref<*xf32>
    call @print_memref_f32(%6) : (memref<*xf32>) -> ()
    %7 = memref_cast %4 : memref<1x128xf32> to memref<*xf32>
    call @print_memref_f32(%7) : (memref<*xf32>) -> ()
    return
  }
}
