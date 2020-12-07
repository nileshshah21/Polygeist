#map0 = affine_map<()[s0] -> ((s0 - 1) floordiv 32 + 1)>
#map1 = affine_map<(d0) -> (d0 * 32)>
#map2 = affine_map<(d0)[s0] -> (s0, d0 * 32 + 32)>
module attributes {llvm.data_layout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128", llvm.target_triple = "x86_64-unknown-linux-gnu"}  {
  llvm.mlir.global internal constant @str6("==END   DUMP_ARRAYS==\0A\00")
  llvm.mlir.global internal constant @str5("\0Aend   dump: %s\0A\00")
  llvm.mlir.global internal constant @str4("%0.2f \00")
  llvm.mlir.global internal constant @str3("\0A\00")
  llvm.mlir.global internal constant @str2("imgOut\00")
  llvm.mlir.global internal constant @str1("begin dump: %s\00")
  llvm.mlir.global internal constant @str0("==BEGIN DUMP_ARRAYS==\0A\00")
  llvm.mlir.global external @stderr() : !llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>
  llvm.func @fprintf(!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, ...) -> !llvm.i32
  func @main(%arg0: i32, %arg1: !llvm.ptr<ptr<i8>>) -> i32 {
    %c0 = constant 0 : index
    %c64_i32 = constant 64 : i32
    %c0_i32 = constant 0 : i32
    %0 = alloca() : memref<1xf32>
    %1 = alloc() : memref<64x64xf32>
    %2 = alloc() : memref<64x64xf32>
    %3 = alloc() : memref<64x64xf32>
    %4 = alloc() : memref<64x64xf32>
    %5 = memref_cast %0 : memref<1xf32> to memref<?xf32>
    call @init_array(%c64_i32, %c64_i32, %5, %1, %2) : (i32, i32, memref<?xf32>, memref<64x64xf32>, memref<64x64xf32>) -> ()
    %6 = load %0[%c0] : memref<1xf32>
    call @kernel_deriche_new(%c64_i32, %c64_i32, %6, %1, %2, %3, %4) : (i32, i32, f32, memref<64x64xf32>, memref<64x64xf32>, memref<64x64xf32>, memref<64x64xf32>) -> ()
    call @print_array(%c64_i32, %c64_i32, %2) : (i32, i32, memref<64x64xf32>) -> ()
    return %c0_i32 : i32
  }
  func private @init_array(%arg0: i32, %arg1: i32, %arg2: memref<?xf32>, %arg3: memref<64x64xf32>, %arg4: memref<64x64xf32>) {
    %c0 = constant 0 : index
    %cst = constant 2.500000e-01 : f64
    %c0_i32 = constant 0 : i32
    %c313_i32 = constant 313 : i32
    %c991_i32 = constant 991 : i32
    %c65536_i32 = constant 65536 : i32
    %cst_0 = constant 6.553500e+04 : f32
    %c1_i32 = constant 1 : i32
    %0 = fptrunc %cst : f64 to f32
    store %0, %arg2[%c0] : memref<?xf32>
    br ^bb1(%c0_i32 : i32)
  ^bb1(%1: i32):  // 2 preds: ^bb0, ^bb5
    %2 = cmpi "slt", %1, %arg0 : i32
    %3 = index_cast %1 : i32 to index
    cond_br %2, ^bb3(%c0_i32 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    return
  ^bb3(%4: i32):  // 2 preds: ^bb1, ^bb4
    %5 = cmpi "slt", %4, %arg1 : i32
    %6 = index_cast %4 : i32 to index
    cond_br %5, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %7 = muli %1, %c313_i32 : i32
    %8 = muli %4, %c991_i32 : i32
    %9 = addi %7, %8 : i32
    %10 = remi_signed %9, %c65536_i32 : i32
    %11 = sitofp %10 : i32 to f32
    %12 = divf %11, %cst_0 : f32
    store %12, %arg3[%3, %6] : memref<64x64xf32>
    %13 = addi %4, %c1_i32 : i32
    br ^bb3(%13 : i32)
  ^bb5:  // pred: ^bb3
    %14 = addi %1, %c1_i32 : i32
    br ^bb1(%14 : i32)
  }
  func private @kernel_deriche(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: memref<64x64xf32>, %arg4: memref<64x64xf32>, %arg5: memref<64x64xf32>, %arg6: memref<64x64xf32>) {
    %0 = alloca() : memref<1xf32>
    %1 = alloca() : memref<1xf32>
    %2 = alloca() : memref<1xf32>
    %3 = alloca() : memref<1xf32>
    %4 = alloca() : memref<1xf32>
    %5 = alloca() : memref<1xf32>
    %6 = alloca() : memref<1xf32>
    %7 = alloca() : memref<1xf32>
    %8 = alloca() : memref<1xf32>
    %9 = alloca() : memref<1xf32>
    %10 = alloca() : memref<1xf32>
    %11 = alloca() : memref<1xf32>
    %12 = alloca() : memref<1xf32>
    %13 = alloca() : memref<1xf32>
    %14 = alloca() : memref<1xf32>
    %15 = alloca() : memref<1xf32>
    %16 = alloca() : memref<1xf32>
    %17 = alloca() : memref<1xf32>
    %18 = alloca() : memref<1xf32>
    %19 = alloca() : memref<1xf32>
    %20 = alloca() : memref<1xf32>
    %21 = alloca() : memref<1xf32>
    %22 = alloca() : memref<1xf32>
    %23 = index_cast %arg1 : i32 to index
    %24 = index_cast %arg0 : i32 to index
    %25 = alloca() : memref<1xf32>
    %26 = alloca() : memref<1xf32>
    %27 = alloca() : memref<1xf32>
    %28 = alloca() : memref<1xf32>
    %29 = alloca() : memref<1xf32>
    %30 = alloca() : memref<1xf32>
    %31 = alloca() : memref<1xf32>
    %32 = alloca() : memref<1xf32>
    %33 = alloca() : memref<1xf32>
    %34 = alloca() : memref<1xf32>
    call @S0(%16, %arg2, %15, %14, %11) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
    call @S1(%17, %arg2, %15, %14, %13, %12) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
    call @S2(%21, %arg2, %13) : (memref<1xf32>, f32, memref<1xf32>) -> ()
    call @S3(%22, %arg2, %12, %10) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>) -> ()
    call @S4(%19, %11) : (memref<1xf32>, memref<1xf32>) -> ()
    call @S5(%20, %10) : (memref<1xf32>, memref<1xf32>) -> ()
    call @S6(%18) : (memref<1xf32>) -> ()
    affine.for %arg7 = 0 to %24 {
      call @S7(%27) : (memref<1xf32>) -> ()
      call @S8(%28) : (memref<1xf32>) -> ()
      call @S9(%25) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %23 {
        call @S10(%arg5, %arg7, %arg8, %28, %20, %27, %19, %25, %17, %arg3, %16, %9, %8, %7) : (memref<64x64xf32>, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<64x64xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S11(%25, %9) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S12(%28, %8) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S13(%27, %7) : (memref<1xf32>, memref<1xf32>) -> ()
      }
    }
    affine.for %arg7 = 0 to %24 {
      call @S14(%33) : (memref<1xf32>) -> ()
      call @S15(%34) : (memref<1xf32>) -> ()
      call @S16(%29) : (memref<1xf32>) -> ()
      call @S17(%30) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %23 {
        call @S18(%arg6, %arg7, %arg8, %23, %34, %20, %33, %19, %30, %22, %29, %21, %6, %5, %4) : (memref<64x64xf32>, index, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S19(%30, %6) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S20(%29, %arg3, %arg7, %arg8, %23) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
        call @S21(%34, %5) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S22(%33, %4) : (memref<1xf32>, memref<1xf32>) -> ()
      }
    }
    affine.for %arg7 = 0 to %24 {
      affine.for %arg8 = 0 to %23 {
        call @S23(%arg4, %arg7, %arg8, %arg6, %arg5, %18) : (memref<64x64xf32>, index, index, memref<64x64xf32>, memref<64x64xf32>, memref<1xf32>) -> ()
      }
    }
    affine.for %arg7 = 0 to %23 {
      call @S24(%26) : (memref<1xf32>) -> ()
      call @S25(%27) : (memref<1xf32>) -> ()
      call @S26(%28) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %24 {
        call @S27(%arg5, %arg8, %arg7, %28, %20, %27, %19, %26, %17, %arg4, %16, %3, %2) : (memref<64x64xf32>, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<64x64xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S28(%26, %3) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S29(%28, %2) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S30(%27, %arg5, %arg8, %arg7) : (memref<1xf32>, memref<64x64xf32>, index, index) -> ()
      }
    }
    affine.for %arg7 = 0 to %23 {
      call @S31(%31) : (memref<1xf32>) -> ()
      call @S32(%32) : (memref<1xf32>) -> ()
      call @S33(%33) : (memref<1xf32>) -> ()
      call @S34(%34) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %24 {
        call @S35(%arg6, %arg8, %arg7, %24, %34, %20, %33, %19, %32, %22, %31, %21, %1, %0) : (memref<64x64xf32>, index, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S36(%32, %1) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S37(%31, %arg4, %arg8, %arg7, %24) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
        call @S38(%34, %0) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S39(%33, %arg6, %arg8, %arg7, %24) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
      }
    }
    affine.for %arg7 = 0 to %24 {
      affine.for %arg8 = 0 to %23 {
        call @S40(%arg4, %arg7, %arg8, %arg6, %arg5, %18) : (memref<64x64xf32>, index, index, memref<64x64xf32>, memref<64x64xf32>, memref<1xf32>) -> ()
      }
    }
    return
  }
  func private @print_array(%arg0: i32, %arg1: i32, %arg2: memref<64x64xf32>) {
    %c0_i32 = constant 0 : i32
    %c20_i32 = constant 20 : i32
    %c1_i32 = constant 1 : i32
    %0 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %1 = llvm.load %0 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %2 = llvm.mlir.addressof @str0 : !llvm.ptr<array<23 x i8>>
    %3 = llvm.mlir.constant(0 : index) : !llvm.i64
    %4 = llvm.getelementptr %2[%3, %3] : (!llvm.ptr<array<23 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %5 = llvm.call @fprintf(%1, %4) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    %6 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %7 = llvm.load %6 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %8 = llvm.mlir.addressof @str1 : !llvm.ptr<array<15 x i8>>
    %9 = llvm.getelementptr %8[%3, %3] : (!llvm.ptr<array<15 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %10 = llvm.mlir.addressof @str2 : !llvm.ptr<array<7 x i8>>
    %11 = llvm.getelementptr %10[%3, %3] : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %12 = llvm.call @fprintf(%7, %9, %11) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
    br ^bb1(%c0_i32 : i32)
  ^bb1(%13: i32):  // 2 preds: ^bb0, ^bb5
    %14 = cmpi "slt", %13, %arg0 : i32
    %15 = index_cast %13 : i32 to index
    cond_br %14, ^bb3(%c0_i32 : i32), ^bb2
  ^bb2:  // pred: ^bb1
    %16 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %17 = llvm.load %16 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %18 = llvm.mlir.addressof @str5 : !llvm.ptr<array<17 x i8>>
    %19 = llvm.getelementptr %18[%3, %3] : (!llvm.ptr<array<17 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %20 = llvm.mlir.addressof @str2 : !llvm.ptr<array<7 x i8>>
    %21 = llvm.getelementptr %20[%3, %3] : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %22 = llvm.call @fprintf(%17, %19, %21) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.ptr<i8>) -> !llvm.i32
    %23 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %24 = llvm.load %23 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %25 = llvm.mlir.addressof @str6 : !llvm.ptr<array<23 x i8>>
    %26 = llvm.getelementptr %25[%3, %3] : (!llvm.ptr<array<23 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %27 = llvm.call @fprintf(%24, %26) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    return
  ^bb3(%28: i32):  // 2 preds: ^bb1, ^bb4
    %29 = cmpi "slt", %28, %arg1 : i32
    %30 = index_cast %28 : i32 to index
    cond_br %29, ^bb4, ^bb5
  ^bb4:  // pred: ^bb3
    %31 = muli %13, %arg1 : i32
    %32 = addi %31, %28 : i32
    %33 = remi_signed %32, %c20_i32 : i32
    %34 = cmpi "eq", %33, %c0_i32 : i32
    scf.if %34 {
      %45 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
      %46 = llvm.load %45 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
      %47 = llvm.mlir.addressof @str3 : !llvm.ptr<array<2 x i8>>
      %48 = llvm.getelementptr %47[%3, %3] : (!llvm.ptr<array<2 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
      %49 = llvm.call @fprintf(%46, %48) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>) -> !llvm.i32
    }
    %35 = llvm.mlir.addressof @stderr : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %36 = llvm.load %35 : !llvm.ptr<ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>>
    %37 = llvm.mlir.addressof @str4 : !llvm.ptr<array<7 x i8>>
    %38 = llvm.getelementptr %37[%3, %3] : (!llvm.ptr<array<7 x i8>>, !llvm.i64, !llvm.i64) -> !llvm.ptr<i8>
    %39 = load %arg2[%15, %30] : memref<64x64xf32>
    %40 = fpext %39 : f32 to f64
    %41 = llvm.mlir.cast %40 : f64 to !llvm.double
    %42 = llvm.call @fprintf(%36, %38, %41) : (!llvm.ptr<struct<"struct._IO_FILE", (i32, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<i8>, ptr<struct<"struct._IO_marker", opaque>>, ptr<struct<"struct._IO_FILE">>, i32, i32, i64, i16, i8, array<1 x i8>, ptr<i8>, i64, ptr<struct<"struct._IO_codecvt", opaque>>, ptr<struct<"struct._IO_wide_data", opaque>>, ptr<struct<"struct._IO_FILE">>, ptr<i8>, i64, i32, array<20 x i8>)>>, !llvm.ptr<i8>, !llvm.double) -> !llvm.i32
    %43 = addi %28, %c1_i32 : i32
    br ^bb3(%43 : i32)
  ^bb5:  // pred: ^bb3
    %44 = addi %13, %c1_i32 : i32
    br ^bb1(%44 : i32)
  }
  func private @S0(%arg0: memref<1xf32>, %arg1: f32, %arg2: memref<1xf32>, %arg3: memref<1xf32>, %arg4: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 2.000000e+00 : f32
    %cst_0 = constant 1.000000e+00 : f32
    %0 = negf %arg1 : f32
    affine.store %0, %arg4[0] : memref<1xf32>
    %1 = exp %0 : f32
    affine.store %1, %arg2[0] : memref<1xf32>
    %2 = subf %cst_0, %1 : f32
    %3 = mulf %2, %2 : f32
    %4 = mulf %cst, %arg1 : f32
    %5 = mulf %4, %1 : f32
    %6 = addf %cst_0, %5 : f32
    %7 = exp %4 : f32
    %8 = subf %6, %7 : f32
    %9 = divf %3, %8 : f32
    affine.store %9, %arg3[0] : memref<1xf32>
    affine.store %9, %arg0[0] : memref<1xf32>
    return
  }
  func private @S1(%arg0: memref<1xf32>, %arg1: f32, %arg2: memref<1xf32>, %arg3: memref<1xf32>, %arg4: memref<1xf32>, %arg5: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f32
    %0 = affine.load %arg3[0] : memref<1xf32>
    affine.store %0, %arg5[0] : memref<1xf32>
    %1 = affine.load %arg2[0] : memref<1xf32>
    %2 = mulf %0, %1 : f32
    affine.store %2, %arg4[0] : memref<1xf32>
    %3 = subf %arg1, %cst : f32
    %4 = mulf %2, %3 : f32
    affine.store %4, %arg0[0] : memref<1xf32>
    return
  }
  func private @S2(%arg0: memref<1xf32>, %arg1: f32, %arg2: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 1.000000e+00 : f32
    %0 = affine.load %arg2[0] : memref<1xf32>
    %1 = addf %arg1, %cst : f32
    %2 = mulf %0, %1 : f32
    affine.store %2, %arg0[0] : memref<1xf32>
    return
  }
  func private @S3(%arg0: memref<1xf32>, %arg1: f32, %arg2: memref<1xf32>, %arg3: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 2.000000e+00 : f32
    %0 = affine.load %arg2[0] : memref<1xf32>
    %1 = negf %0 : f32
    %2 = negf %cst : f32
    %3 = mulf %2, %arg1 : f32
    %4 = exp %3 : f32
    affine.store %4, %arg3[0] : memref<1xf32>
    %5 = mulf %1, %4 : f32
    affine.store %5, %arg0[0] : memref<1xf32>
    return
  }
  func private @S4(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 2.000000e+00 : f32
    %0 = llvm.mlir.cast %cst : f32 to !llvm.float
    %1 = affine.load %arg1[0] : memref<1xf32>
    %2 = llvm.mlir.cast %1 : f32 to !llvm.float
    %3 = "llvm.intr.pow"(%0, %2) : (!llvm.float, !llvm.float) -> !llvm.float
    %4 = llvm.mlir.cast %3 : !llvm.float to f32
    affine.store %4, %arg0[0] : memref<1xf32>
    return
  }
  func private @S5(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    %1 = negf %0 : f32
    affine.store %1, %arg0[0] : memref<1xf32>
    return
  }
  func private @S6(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %c1_i32 = constant 1 : i32
    %0 = sitofp %c1_i32 : i32 to f32
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S7(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S8(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S9(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S10(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: memref<1xf32>, %arg4: memref<1xf32>, %arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>, %arg9: memref<64x64xf32>, %arg10: memref<1xf32>, %arg11: memref<1xf32>, %arg12: memref<1xf32>, %arg13: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg10[0] : memref<1xf32>
    %1 = affine.load %arg9[%arg1, %arg2] : memref<64x64xf32>
    affine.store %1, %arg11[0] : memref<1xf32>
    %2 = mulf %0, %1 : f32
    %3 = affine.load %arg8[0] : memref<1xf32>
    %4 = affine.load %arg7[0] : memref<1xf32>
    %5 = mulf %3, %4 : f32
    %6 = addf %2, %5 : f32
    %7 = affine.load %arg6[0] : memref<1xf32>
    %8 = affine.load %arg5[0] : memref<1xf32>
    affine.store %8, %arg12[0] : memref<1xf32>
    %9 = mulf %7, %8 : f32
    %10 = addf %6, %9 : f32
    %11 = affine.load %arg4[0] : memref<1xf32>
    %12 = affine.load %arg3[0] : memref<1xf32>
    %13 = mulf %11, %12 : f32
    %14 = addf %10, %13 : f32
    affine.store %14, %arg13[0] : memref<1xf32>
    affine.store %14, %arg0[%arg1, %arg2] : memref<64x64xf32>
    return
  }
  func private @S11(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S12(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S13(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S14(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S15(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S16(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S17(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S18(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<1xf32>, %arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>, %arg9: memref<1xf32>, %arg10: memref<1xf32>, %arg11: memref<1xf32>, %arg12: memref<1xf32>, %arg13: memref<1xf32>, %arg14: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg11[0] : memref<1xf32>
    %1 = affine.load %arg10[0] : memref<1xf32>
    affine.store %1, %arg12[0] : memref<1xf32>
    %2 = mulf %0, %1 : f32
    %3 = affine.load %arg9[0] : memref<1xf32>
    %4 = affine.load %arg8[0] : memref<1xf32>
    %5 = mulf %3, %4 : f32
    %6 = addf %2, %5 : f32
    %7 = affine.load %arg7[0] : memref<1xf32>
    %8 = affine.load %arg6[0] : memref<1xf32>
    affine.store %8, %arg13[0] : memref<1xf32>
    %9 = mulf %7, %8 : f32
    %10 = addf %6, %9 : f32
    %11 = affine.load %arg5[0] : memref<1xf32>
    %12 = affine.load %arg4[0] : memref<1xf32>
    %13 = mulf %11, %12 : f32
    %14 = addf %10, %13 : f32
    affine.store %14, %arg14[0] : memref<1xf32>
    affine.store %14, %arg0[%arg1, -%arg2 + symbol(%arg3) - 1] : memref<64x64xf32>
    return
  }
  func private @S19(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S20(%arg0: memref<1xf32>, %arg1: memref<64x64xf32>, %arg2: index, %arg3: index, %arg4: index) attributes {scop.stmt} {
    %0 = affine.load %arg1[%arg2, -%arg3 + symbol(%arg4) - 1] : memref<64x64xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S21(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S22(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S23(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: memref<64x64xf32>, %arg4: memref<64x64xf32>, %arg5: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg5[0] : memref<1xf32>
    %1 = affine.load %arg4[%arg1, %arg2] : memref<64x64xf32>
    %2 = affine.load %arg3[%arg1, %arg2] : memref<64x64xf32>
    %3 = addf %1, %2 : f32
    %4 = mulf %0, %3 : f32
    affine.store %4, %arg0[%arg1, %arg2] : memref<64x64xf32>
    return
  }
  func private @S24(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S25(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S26(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S27(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: memref<1xf32>, %arg4: memref<1xf32>, %arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>, %arg9: memref<64x64xf32>, %arg10: memref<1xf32>, %arg11: memref<1xf32>, %arg12: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg10[0] : memref<1xf32>
    %1 = affine.load %arg9[%arg1, %arg2] : memref<64x64xf32>
    affine.store %1, %arg11[0] : memref<1xf32>
    %2 = mulf %0, %1 : f32
    %3 = affine.load %arg8[0] : memref<1xf32>
    %4 = affine.load %arg7[0] : memref<1xf32>
    %5 = mulf %3, %4 : f32
    %6 = addf %2, %5 : f32
    %7 = affine.load %arg6[0] : memref<1xf32>
    %8 = affine.load %arg5[0] : memref<1xf32>
    affine.store %8, %arg12[0] : memref<1xf32>
    %9 = mulf %7, %8 : f32
    %10 = addf %6, %9 : f32
    %11 = affine.load %arg4[0] : memref<1xf32>
    %12 = affine.load %arg3[0] : memref<1xf32>
    %13 = mulf %11, %12 : f32
    %14 = addf %10, %13 : f32
    affine.store %14, %arg0[%arg1, %arg2] : memref<64x64xf32>
    return
  }
  func private @S28(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S29(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S30(%arg0: memref<1xf32>, %arg1: memref<64x64xf32>, %arg2: index, %arg3: index) attributes {scop.stmt} {
    %0 = affine.load %arg1[%arg2, %arg3] : memref<64x64xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S31(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S32(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S33(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S34(%arg0: memref<1xf32>) attributes {scop.stmt} {
    %cst = constant 0.000000e+00 : f32
    affine.store %cst, %arg0[0] : memref<1xf32>
    return
  }
  func private @S35(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: index, %arg4: memref<1xf32>, %arg5: memref<1xf32>, %arg6: memref<1xf32>, %arg7: memref<1xf32>, %arg8: memref<1xf32>, %arg9: memref<1xf32>, %arg10: memref<1xf32>, %arg11: memref<1xf32>, %arg12: memref<1xf32>, %arg13: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg11[0] : memref<1xf32>
    %1 = affine.load %arg10[0] : memref<1xf32>
    affine.store %1, %arg12[0] : memref<1xf32>
    %2 = mulf %0, %1 : f32
    %3 = affine.load %arg9[0] : memref<1xf32>
    %4 = affine.load %arg8[0] : memref<1xf32>
    %5 = mulf %3, %4 : f32
    %6 = addf %2, %5 : f32
    %7 = affine.load %arg7[0] : memref<1xf32>
    %8 = affine.load %arg6[0] : memref<1xf32>
    affine.store %8, %arg13[0] : memref<1xf32>
    %9 = mulf %7, %8 : f32
    %10 = addf %6, %9 : f32
    %11 = affine.load %arg5[0] : memref<1xf32>
    %12 = affine.load %arg4[0] : memref<1xf32>
    %13 = mulf %11, %12 : f32
    %14 = addf %10, %13 : f32
    affine.store %14, %arg0[-%arg1 + symbol(%arg3) - 1, %arg2] : memref<64x64xf32>
    return
  }
  func private @S36(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S37(%arg0: memref<1xf32>, %arg1: memref<64x64xf32>, %arg2: index, %arg3: index, %arg4: index) attributes {scop.stmt} {
    %0 = affine.load %arg1[-%arg2 + symbol(%arg4) - 1, %arg3] : memref<64x64xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S38(%arg0: memref<1xf32>, %arg1: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg1[0] : memref<1xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S39(%arg0: memref<1xf32>, %arg1: memref<64x64xf32>, %arg2: index, %arg3: index, %arg4: index) attributes {scop.stmt} {
    %0 = affine.load %arg1[-%arg2 + symbol(%arg4) - 1, %arg3] : memref<64x64xf32>
    affine.store %0, %arg0[0] : memref<1xf32>
    return
  }
  func private @S40(%arg0: memref<64x64xf32>, %arg1: index, %arg2: index, %arg3: memref<64x64xf32>, %arg4: memref<64x64xf32>, %arg5: memref<1xf32>) attributes {scop.stmt} {
    %0 = affine.load %arg5[0] : memref<1xf32>
    %1 = affine.load %arg4[%arg1, %arg2] : memref<64x64xf32>
    %2 = affine.load %arg3[%arg1, %arg2] : memref<64x64xf32>
    %3 = addf %1, %2 : f32
    %4 = mulf %0, %3 : f32
    affine.store %4, %arg0[%arg1, %arg2] : memref<64x64xf32>
    return
  }
  func private @kernel_deriche_new(%arg0: i32, %arg1: i32, %arg2: f32, %arg3: memref<64x64xf32>, %arg4: memref<64x64xf32>, %arg5: memref<64x64xf32>, %arg6: memref<64x64xf32>) {
    %0 = alloca() : memref<1xf32>
    %1 = alloca() : memref<1xf32>
    %2 = alloca() : memref<1xf32>
    %3 = alloca() : memref<1xf32>
    %4 = alloca() : memref<1xf32>
    %5 = alloca() : memref<1xf32>
    %6 = alloca() : memref<1xf32>
    %7 = alloca() : memref<1xf32>
    %8 = alloca() : memref<1xf32>
    %9 = alloca() : memref<1xf32>
    %10 = alloca() : memref<1xf32>
    %11 = alloca() : memref<1xf32>
    %12 = alloca() : memref<1xf32>
    %13 = alloca() : memref<1xf32>
    %14 = alloca() : memref<1xf32>
    %15 = alloca() : memref<1xf32>
    %16 = alloca() : memref<1xf32>
    %17 = alloca() : memref<1xf32>
    %18 = alloca() : memref<1xf32>
    %19 = alloca() : memref<1xf32>
    %20 = alloca() : memref<1xf32>
    %21 = alloca() : memref<1xf32>
    %22 = alloca() : memref<1xf32>
    %23 = alloca() : memref<1xf32>
    %24 = alloca() : memref<1xf32>
    %25 = alloca() : memref<1xf32>
    %26 = alloca() : memref<1xf32>
    %27 = alloca() : memref<1xf32>
    %28 = alloca() : memref<1xf32>
    %29 = alloca() : memref<1xf32>
    %30 = alloca() : memref<1xf32>
    %31 = alloca() : memref<1xf32>
    %32 = alloca() : memref<1xf32>
    %33 = index_cast %arg0 : i32 to index
    %34 = index_cast %arg1 : i32 to index
    call @S0(%20, %arg2, %22, %21, %23) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
    call @S1(%17, %arg2, %22, %21, %18, %19) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
    call @S2(%16, %arg2, %18) : (memref<1xf32>, f32, memref<1xf32>) -> ()
    call @S3(%32, %arg2, %19, %15) : (memref<1xf32>, f32, memref<1xf32>, memref<1xf32>) -> ()
    call @S4(%31, %23) : (memref<1xf32>, memref<1xf32>) -> ()
    call @S5(%30, %15) : (memref<1xf32>, memref<1xf32>) -> ()
    call @S6(%29) : (memref<1xf32>) -> ()
    affine.for %arg7 = 0 to %33 {
      call @S7(%28) : (memref<1xf32>) -> ()
      call @S8(%27) : (memref<1xf32>) -> ()
      call @S9(%26) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %34 {
        call @S10(%arg5, %arg7, %arg8, %27, %30, %28, %31, %26, %17, %arg3, %20, %25, %24, %14) : (memref<64x64xf32>, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<64x64xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S11(%26, %25) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S12(%27, %24) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S13(%28, %14) : (memref<1xf32>, memref<1xf32>) -> ()
      }
    }
    affine.for %arg7 = 0 to %33 {
      call @S14(%13) : (memref<1xf32>) -> ()
      call @S15(%12) : (memref<1xf32>) -> ()
      call @S16(%11) : (memref<1xf32>) -> ()
      call @S17(%10) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %34 {
        call @S18(%arg6, %arg7, %arg8, %34, %12, %30, %13, %31, %10, %32, %11, %16, %9, %8, %7) : (memref<64x64xf32>, index, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S19(%10, %9) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S20(%11, %arg3, %arg7, %arg8, %34) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
        call @S21(%12, %8) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S22(%13, %7) : (memref<1xf32>, memref<1xf32>) -> ()
      }
    }
    affine.for %arg7 = 0 to #map0()[%33] {
      affine.for %arg8 = 0 to #map0()[%34] {
        affine.for %arg9 = #map1(%arg7) to min #map2(%arg7)[%33] {
          affine.for %arg10 = #map1(%arg8) to min #map2(%arg8)[%34] {
            call @S23(%arg4, %arg9, %arg10, %arg6, %arg5, %29) : (memref<64x64xf32>, index, index, memref<64x64xf32>, memref<64x64xf32>, memref<1xf32>) -> ()
          }
        }
      }
    }
    affine.for %arg7 = 0 to %34 {
      call @S24(%6) : (memref<1xf32>) -> ()
      call @S25(%28) : (memref<1xf32>) -> ()
      call @S26(%27) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %33 {
        call @S27(%arg5, %arg8, %arg7, %27, %30, %28, %31, %6, %17, %arg4, %20, %5, %4) : (memref<64x64xf32>, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<64x64xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S28(%6, %5) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S29(%27, %4) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S30(%28, %arg5, %arg8, %arg7) : (memref<1xf32>, memref<64x64xf32>, index, index) -> ()
      }
    }
    affine.for %arg7 = 0 to %34 {
      call @S31(%3) : (memref<1xf32>) -> ()
      call @S32(%2) : (memref<1xf32>) -> ()
      call @S33(%13) : (memref<1xf32>) -> ()
      call @S34(%12) : (memref<1xf32>) -> ()
      affine.for %arg8 = 0 to %33 {
        call @S35(%arg6, %arg8, %arg7, %33, %12, %30, %13, %31, %2, %32, %3, %16, %1, %0) : (memref<64x64xf32>, index, index, index, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>, memref<1xf32>) -> ()
        call @S36(%2, %1) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S37(%3, %arg4, %arg8, %arg7, %33) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
        call @S38(%12, %0) : (memref<1xf32>, memref<1xf32>) -> ()
        call @S39(%13, %arg6, %arg8, %arg7, %33) : (memref<1xf32>, memref<64x64xf32>, index, index, index) -> ()
      }
    }
    affine.for %arg7 = 0 to #map0()[%33] {
      affine.for %arg8 = 0 to #map0()[%34] {
        affine.for %arg9 = #map1(%arg7) to min #map2(%arg7)[%33] {
          affine.for %arg10 = #map1(%arg8) to min #map2(%arg8)[%34] {
            call @S40(%arg4, %arg9, %arg10, %arg6, %arg5, %29) : (memref<64x64xf32>, index, index, memref<64x64xf32>, memref<64x64xf32>, memref<1xf32>) -> ()
          }
        }
      }
    }
    return
  }
}
