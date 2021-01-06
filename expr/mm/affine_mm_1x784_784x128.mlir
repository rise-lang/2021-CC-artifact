#map0 = affine_map<(d0, d1) -> (d0, d1)>
#map1 = affine_map<() -> (0)>
#map2 = affine_map<() -> (784)>
#map3 = affine_map<() -> (128)>
#map4 = affine_map<() -> (1)>


module {
  func @print_memref_f32(memref<*xf32>)
  func @print_f32(f32)
  func @print_bin_op(f32, f32, f32)
  func @print_time(f64, f64)
  func @rtclock() -> f64
  func @mm(%arg0: memref<1x784xf32>, %arg1: memref<784x128xf32>, %arg2: memref<1x128xf32>) {
    %cst = constant 0.000000e+00 : f32
    affine.for %arg3 = 0 to 1 {
      affine.for %arg4 = 0 to 128 {
        affine.store %cst, %arg2[%arg3, %arg4] : memref<1x128xf32>
        affine.for %arg5 = 0 to 784 {
          %0 = affine.load %arg0[%arg3, %arg5] : memref<1x784xf32>
          %1 = affine.load %arg1[%arg5, %arg4] : memref<784x128xf32>
          %2 = affine.load %arg2[%arg3, %arg4] : memref<1x128xf32>
          %3 = mulf %0, %1 : f32
          %4 = addf %2, %3 : f32
          affine.store %4, %arg2[%arg3, %arg4] : memref<1x128xf32>
        }
      }
    }
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