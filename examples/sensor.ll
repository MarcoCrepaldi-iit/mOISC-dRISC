; ModuleID = 'examples/sensor.c'
source_filename = "examples/sensor.c"
target datalayout = "e-m:o-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-apple-macosx11.0.0"

@mOISC_ior = global i32* inttoptr (i64 7 to i32*), align 8
@mOISC_idr = global i32* inttoptr (i64 6 to i32*), align 8
@mOISC_isr = global i32* inttoptr (i64 5 to i32*), align 8
@mOISC_csr = global i32* inttoptr (i64 4 to i32*), align 8
@mOISC_icr = global i32* inttoptr (i64 3 to i32*), align 8
@mOISC_iwr = global i32* inttoptr (i64 2 to i32*), align 8
@mOISC_chr = global i32* inttoptr (i64 1 to i32*), align 8
@mOISC_mcr = global i32* null, align 8
@current_idr = global i32 192, align 4

; Function Attrs: noinline nounwind optnone uwtable
define void @memcpy(i8* %0, i8* %1, i32 %2) #0 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i32, align 4
  %7 = alloca i32*, align 8
  %8 = alloca i32*, align 8
  %9 = alloca i32, align 4
  store i8* %0, i8** %4, align 8
  store i8* %1, i8** %5, align 8
  store i32 %2, i32* %6, align 4
  %10 = load i8*, i8** %5, align 8
  %11 = bitcast i8* %10 to i32*
  store i32* %11, i32** %7, align 8
  %12 = load i8*, i8** %4, align 8
  %13 = bitcast i8* %12 to i32*
  store i32* %13, i32** %8, align 8
  store i32 0, i32* %9, align 4
  br label %14

14:                                               ; preds = %28, %3
  %15 = load i32, i32* %9, align 4
  %16 = load i32, i32* %6, align 4
  %17 = icmp slt i32 %15, %16
  br i1 %17, label %18, label %31

18:                                               ; preds = %14
  %19 = load i32*, i32** %7, align 8
  %20 = load i32, i32* %9, align 4
  %21 = sext i32 %20 to i64
  %22 = getelementptr inbounds i32, i32* %19, i64 %21
  %23 = load i32, i32* %22, align 4
  %24 = load i32*, i32** %8, align 8
  %25 = load i32, i32* %9, align 4
  %26 = sext i32 %25 to i64
  %27 = getelementptr inbounds i32, i32* %24, i64 %26
  store i32 %23, i32* %27, align 4
  br label %28

28:                                               ; preds = %18
  %29 = load i32, i32* %9, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %9, align 4
  br label %14

31:                                               ; preds = %14
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @delay(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 1, i32* %3, align 4
  br label %4

4:                                                ; preds = %9, %1
  %5 = load i32, i32* %3, align 4
  %6 = load i32, i32* %2, align 4
  %7 = icmp sle i32 %5, %6
  br i1 %7, label %8, label %12

8:                                                ; preds = %4
  br label %9

9:                                                ; preds = %8
  %10 = load i32, i32* %3, align 4
  %11 = add nsw i32 %10, 1
  store i32 %11, i32* %3, align 4
  br label %4

12:                                               ; preds = %4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @spi_ll(i32 %0, i32 %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32 %2, i32* %6, align 4
  store i32 0, i32* %11, align 4
  store i32 0, i32* %12, align 4
  store i32 0, i32* %13, align 4
  %14 = load i32*, i32** @mOISC_ior, align 8
  %15 = load volatile i32, i32* %14, align 4
  %16 = and i32 %15, 247
  store i32 %16, i32* %13, align 4
  %17 = load i32, i32* %4, align 4
  %18 = and i32 %17, 127
  %19 = load i32, i32* %5, align 4
  %20 = shl i32 %19, 7
  %21 = or i32 %18, %20
  store i32 %21, i32* %12, align 4
  %22 = load i32, i32* %13, align 4
  %23 = or i32 0, %22
  %24 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %23, i32* %24, align 4
  store i32 0, i32* %9, align 4
  br label %25

25:                                               ; preds = %43, %3
  %26 = load i32, i32* %9, align 4
  %27 = icmp slt i32 %26, 8
  br i1 %27, label %28, label %46

28:                                               ; preds = %25
  %29 = load i32, i32* %12, align 4
  %30 = load i32, i32* %9, align 4
  %31 = sub nsw i32 7, %30
  %32 = ashr i32 %29, %31
  %33 = and i32 %32, 1
  store i32 %33, i32* %8, align 4
  %34 = load i32, i32* %8, align 4
  %35 = load i32, i32* %13, align 4
  %36 = or i32 %34, %35
  %37 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %36, i32* %37, align 4
  %38 = load i32, i32* %8, align 4
  %39 = or i32 2, %38
  %40 = load i32, i32* %13, align 4
  %41 = or i32 %39, %40
  %42 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %41, i32* %42, align 4
  br label %43

43:                                               ; preds = %28
  %44 = load i32, i32* %9, align 4
  %45 = add nsw i32 %44, 1
  store i32 %45, i32* %9, align 4
  br label %25

46:                                               ; preds = %25
  store i32 0, i32* %9, align 4
  br label %47

47:                                               ; preds = %76, %46
  %48 = load i32, i32* %9, align 4
  %49 = icmp slt i32 %48, 8
  br i1 %49, label %50, label %79

50:                                               ; preds = %47
  %51 = load i32, i32* %6, align 4
  %52 = load i32, i32* %9, align 4
  %53 = sub nsw i32 7, %52
  %54 = ashr i32 %51, %53
  %55 = and i32 %54, 1
  store i32 %55, i32* %10, align 4
  %56 = load i32, i32* %10, align 4
  %57 = or i32 0, %56
  %58 = load i32, i32* %13, align 4
  %59 = or i32 %57, %58
  %60 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %59, i32* %60, align 4
  %61 = load i32*, i32** @mOISC_ior, align 8
  %62 = load volatile i32, i32* %61, align 4
  %63 = and i32 %62, 4
  %64 = ashr i32 %63, 2
  store i32 %64, i32* %7, align 4
  %65 = load i32, i32* %11, align 4
  %66 = load i32, i32* %7, align 4
  %67 = load i32, i32* %9, align 4
  %68 = sub nsw i32 7, %67
  %69 = shl i32 %66, %68
  %70 = or i32 %65, %69
  store i32 %70, i32* %11, align 4
  %71 = load i32, i32* %10, align 4
  %72 = or i32 2, %71
  %73 = load i32, i32* %13, align 4
  %74 = or i32 %72, %73
  %75 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %74, i32* %75, align 4
  br label %76

76:                                               ; preds = %50
  %77 = load i32, i32* %9, align 4
  %78 = add nsw i32 %77, 1
  store i32 %78, i32* %9, align 4
  br label %47

79:                                               ; preds = %47
  %80 = load i32, i32* %13, align 4
  %81 = or i32 0, %80
  %82 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %81, i32* %82, align 4
  call void @delay(i32 5) #2
  %83 = load i32, i32* %13, align 4
  %84 = or i32 8, %83
  %85 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %84, i32* %85, align 4
  %86 = load i32, i32* %11, align 4
  ret i32 %86
}

; Function Attrs: noinline nounwind optnone uwtable
define void @spitransaction(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* %6, align 4
  store i32 0, i32* %7, align 4
  store i32 0, i32* %8, align 4
  %9 = load i32*, i32** @mOISC_ior, align 8
  %10 = load volatile i32, i32* %9, align 4
  store i32 %10, i32* %8, align 4
  %11 = load i32, i32* %2, align 4
  %12 = and i32 %11, 255
  store i32 %12, i32* %7, align 4
  store i32 0, i32* %4, align 4
  br label %13

13:                                               ; preds = %31, %1
  %14 = load i32, i32* %4, align 4
  %15 = icmp slt i32 %14, 8
  br i1 %15, label %16, label %34

16:                                               ; preds = %13
  %17 = load i32, i32* %7, align 4
  %18 = load i32, i32* %4, align 4
  %19 = sub nsw i32 7, %18
  %20 = ashr i32 %17, %19
  %21 = and i32 %20, 1
  store i32 %21, i32* %3, align 4
  %22 = load i32, i32* %3, align 4
  %23 = load i32, i32* %8, align 4
  %24 = or i32 %22, %23
  %25 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %24, i32* %25, align 4
  %26 = load i32, i32* %3, align 4
  %27 = or i32 2, %26
  %28 = load i32, i32* %8, align 4
  %29 = or i32 %27, %28
  %30 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %29, i32* %30, align 4
  br label %31

31:                                               ; preds = %16
  %32 = load i32, i32* %4, align 4
  %33 = add nsw i32 %32, 1
  store i32 %33, i32* %4, align 4
  br label %13

34:                                               ; preds = %13
  %35 = load i32, i32* %8, align 4
  %36 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %35, i32* %36, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @spiselect() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32*, i32** @mOISC_ior, align 8
  %3 = load volatile i32, i32* %2, align 4
  %4 = and i32 %3, 247
  store i32 %4, i32* %1, align 4
  %5 = load i32, i32* %1, align 4
  %6 = and i32 247, %5
  %7 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %6, i32* %7, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @spiunselect() #0 {
  %1 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %2 = load i32*, i32** @mOISC_ior, align 8
  %3 = load volatile i32, i32* %2, align 4
  store i32 %3, i32* %1, align 4
  %4 = load i32, i32* %1, align 4
  %5 = or i32 8, %4
  %6 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %5, i32* %6, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @spiLEDInit() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = or i32 %1, 59
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  %5 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 8, i32* %5, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @spiWrite(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  store i32 1, i32* %5, align 4
  %6 = load i32, i32* %3, align 4
  %7 = load i32, i32* %5, align 4
  %8 = load i32, i32* %4, align 4
  %9 = call i32 @spi_ll(i32 %6, i32 %7, i32 %8) #2
  ret i32 %9
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @spiRead(i32 %0) #0 {
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  store i32 0, i32* %3, align 4
  %4 = load i32, i32* %2, align 4
  %5 = load i32, i32* %3, align 4
  %6 = call i32 @spi_ll(i32 %4, i32 %5, i32 0) #2
  ret i32 %6
}

; Function Attrs: noinline nounwind optnone uwtable
define void @spiBurstWrite(i32 %0, i32* %1, i32 %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32*, align 8
  %6 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32* %1, i32** %5, align 8
  store i32 %2, i32* %6, align 4
  call void @spiselect() #2
  %7 = load i32, i32* %4, align 4
  %8 = or i32 %7, 128
  call void @spitransaction(i32 %8) #2
  br label %9

9:                                                ; preds = %13, %3
  %10 = load i32, i32* %6, align 4
  %11 = add nsw i32 %10, -1
  store i32 %11, i32* %6, align 4
  %12 = icmp ne i32 %10, 0
  br i1 %12, label %13, label %19

13:                                               ; preds = %9
  %14 = load i32*, i32** %5, align 8
  %15 = load i32, i32* %6, align 4
  %16 = sext i32 %15 to i64
  %17 = getelementptr inbounds i32, i32* %14, i64 %16
  %18 = load i32, i32* %17, align 4
  call void @spitransaction(i32 %18) #2
  br label %9

19:                                               ; preds = %9
  call void @spiunselect() #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setFrequency_868() #0 {
  %1 = call i32 @spiWrite(i32 6, i32 217) #2
  %2 = call i32 @spiWrite(i32 7, i32 0) #2
  %3 = call i32 @spiWrite(i32 8, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setFrequency_915() #0 {
  %1 = call i32 @spiWrite(i32 6, i32 228) #2
  %2 = call i32 @spiWrite(i32 7, i32 192) #2
  %3 = call i32 @spiWrite(i32 8, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setPreambleLength(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = ashr i32 %3, 8
  %5 = call i32 @spiWrite(i32 32, i32 %4) #2
  %6 = load i32, i32* %2, align 4
  %7 = and i32 %6, 255
  %8 = call i32 @spiWrite(i32 33, i32 %7) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModeIdle() #0 {
  %1 = call i32 @spiWrite(i32 1, i32 1) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw125Cr45Sf128() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 114) #2
  %2 = call i32 @spiWrite(i32 30, i32 116) #2
  %3 = call i32 @spiWrite(i32 38, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw500Cr45Sf128() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 146) #2
  %2 = call i32 @spiWrite(i32 30, i32 116) #2
  %3 = call i32 @spiWrite(i32 38, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw31_25Cr48Sf512() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 72) #2
  %2 = call i32 @spiWrite(i32 30, i32 148) #2
  %3 = call i32 @spiWrite(i32 38, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw125Cr48Sf4096() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 120) #2
  %2 = call i32 @spiWrite(i32 30, i32 196) #2
  %3 = call i32 @spiWrite(i32 38, i32 0) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setTxPower(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sub nsw i32 %3, 5
  %5 = or i32 128, %4
  %6 = call i32 @spiWrite(i32 9, i32 %5) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModeTx() #0 {
  %1 = call i32 @spiWrite(i32 1, i32 3) #2
  %2 = call i32 @spiWrite(i32 64, i32 64) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @RH_RF95_send(i32* %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32*, align 8
  %5 = alloca i32, align 4
  store i32* %0, i32** %4, align 8
  store i32 %1, i32* %5, align 4
  %6 = load i32, i32* %5, align 4
  %7 = icmp sgt i32 %6, 251
  br i1 %7, label %8, label %9

8:                                                ; preds = %2
  store i32 0, i32* %3, align 4
  br label %26

9:                                                ; preds = %2
  call void @RH_RF95_setModeIdle() #2
  %10 = call i32 @spiWrite(i32 13, i32 0) #2
  %11 = call i32 @spiWrite(i32 0, i32 255) #2
  %12 = call i32 @spiWrite(i32 0, i32 255) #2
  %13 = call i32 @spiWrite(i32 0, i32 0) #2
  %14 = call i32 @spiWrite(i32 0, i32 0) #2
  %15 = load i32*, i32** %4, align 8
  %16 = load i32, i32* %5, align 4
  call void @spiBurstWrite(i32 0, i32* %15, i32 %16) #2
  %17 = load i32, i32* %5, align 4
  %18 = add nsw i32 %17, 4
  %19 = call i32 @spiWrite(i32 34, i32 %18) #2
  call void @RH_RF95_setModeTx() #2
  br label %20

20:                                               ; preds = %24, %9
  %21 = call i32 @spiRead(i32 18) #2
  %22 = and i32 %21, 8
  %23 = icmp ne i32 %22, 8
  br i1 %23, label %24, label %25

24:                                               ; preds = %20
  br label %20

25:                                               ; preds = %20
  store i32 1, i32* %3, align 4
  br label %26

26:                                               ; preds = %25, %8
  %27 = load i32, i32* %3, align 4
  ret i32 %27
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @RH_RF95_init() #0 {
  %1 = alloca i32, align 4
  %2 = call i32 @spiWrite(i32 1, i32 128) #2
  call void @delay(i32 200) #2
  %3 = call i32 @spiRead(i32 1) #2
  %4 = icmp ne i32 %3, 128
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 0, i32* %1, align 4
  br label %9

6:                                                ; preds = %0
  %7 = call i32 @spiWrite(i32 14, i32 0) #2
  %8 = call i32 @spiWrite(i32 15, i32 0) #2
  call void @RH_RF95_setModeIdle() #2
  call void @RH_RF95_setModemConfig_Bw125Cr45Sf128() #2
  call void @RH_RF95_setPreambleLength(i32 8) #2
  call void @RH_RF95_setFrequency_868() #2
  call void @RH_RF95_setTxPower(i32 13) #2
  store i32 1, i32* %1, align 4
  br label %9

9:                                                ; preds = %6, %5
  %10 = load i32, i32* %1, align 4
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_low_scl() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = or i32 %1, 128
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  %5 = load i32*, i32** @mOISC_ior, align 8
  %6 = load volatile i32, i32* %5, align 4
  %7 = and i32 63, %6
  %8 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %7, i32* %8, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_high_scl() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = and i32 %1, 127
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_low_sda() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = or i32 %1, 64
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  %5 = load i32*, i32** @mOISC_ior, align 8
  %6 = load volatile i32, i32* %5, align 4
  %7 = and i32 191, %6
  %8 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %7, i32* %8, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_release_sda() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = and i32 %1, 191
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_drive_sda() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = or i32 %1, 64
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_high_sda() #0 {
  %1 = load i32, i32* @current_idr, align 4
  %2 = and i32 %1, 191
  store i32 %2, i32* @current_idr, align 4
  %3 = load i32, i32* @current_idr, align 4
  %4 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 %3, i32* %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_init() #0 {
  call void @i2c_high_sda() #2
  call void @i2c_high_scl() #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @i2c_write(i32 %0, i32 %1, i32 %2, i32 %3, i32 %4) #0 {
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  %14 = alloca i32, align 4
  %15 = alloca i32, align 4
  %16 = alloca i32, align 4
  %17 = alloca i32, align 4
  %18 = alloca i32, align 4
  store i32 %0, i32* %6, align 4
  store i32 %1, i32* %7, align 4
  store i32 %2, i32* %8, align 4
  store i32 %3, i32* %9, align 4
  store i32 %4, i32* %10, align 4
  call void @i2c_low_sda() #2
  call void @i2c_low_scl() #2
  store i32 0, i32* %11, align 4
  %19 = load i32*, i32** @mOISC_ior, align 8
  %20 = load volatile i32, i32* %19, align 4
  store i32 %20, i32* %11, align 4
  store i32 0, i32* %13, align 4
  br label %21

21:                                               ; preds = %35, %5
  %22 = load i32, i32* %13, align 4
  %23 = icmp slt i32 %22, 7
  br i1 %23, label %24, label %38

24:                                               ; preds = %21
  %25 = load i32, i32* %6, align 4
  %26 = load i32, i32* %13, align 4
  %27 = sub nsw i32 6, %26
  %28 = ashr i32 %25, %27
  %29 = and i32 %28, 1
  store i32 %29, i32* %14, align 4
  %30 = load i32, i32* %14, align 4
  %31 = icmp eq i32 %30, 1
  br i1 %31, label %32, label %33

32:                                               ; preds = %24
  call void @i2c_high_sda() #2
  br label %34

33:                                               ; preds = %24
  call void @i2c_low_sda() #2
  br label %34

34:                                               ; preds = %33, %32
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %35

35:                                               ; preds = %34
  %36 = load i32, i32* %13, align 4
  %37 = add nsw i32 %36, 1
  store i32 %37, i32* %13, align 4
  br label %21

38:                                               ; preds = %21
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %39 = load i32*, i32** @mOISC_ior, align 8
  %40 = load volatile i32, i32* %39, align 4
  %41 = and i32 %40, 64
  %42 = ashr i32 %41, 6
  store i32 %42, i32* %12, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  store i32 0, i32* %15, align 4
  br label %43

43:                                               ; preds = %57, %38
  %44 = load i32, i32* %15, align 4
  %45 = icmp slt i32 %44, 8
  br i1 %45, label %46, label %60

46:                                               ; preds = %43
  %47 = load i32, i32* %7, align 4
  %48 = load i32, i32* %15, align 4
  %49 = sub nsw i32 7, %48
  %50 = ashr i32 %47, %49
  %51 = and i32 %50, 1
  store i32 %51, i32* %14, align 4
  %52 = load i32, i32* %14, align 4
  %53 = icmp eq i32 %52, 1
  br i1 %53, label %54, label %55

54:                                               ; preds = %46
  call void @i2c_high_sda() #2
  br label %56

55:                                               ; preds = %46
  call void @i2c_low_sda() #2
  br label %56

56:                                               ; preds = %55, %54
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %57

57:                                               ; preds = %56
  %58 = load i32, i32* %15, align 4
  %59 = add nsw i32 %58, 1
  store i32 %59, i32* %15, align 4
  br label %43

60:                                               ; preds = %43
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %61 = load i32*, i32** @mOISC_ior, align 8
  %62 = load volatile i32, i32* %61, align 4
  %63 = and i32 %62, 64
  %64 = ashr i32 %63, 6
  store i32 %64, i32* %12, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  store i32 0, i32* %16, align 4
  %65 = load i32, i32* %10, align 4
  %66 = icmp eq i32 %65, 2
  br i1 %66, label %67, label %69

67:                                               ; preds = %60
  %68 = load i32, i32* %8, align 4
  store i32 %68, i32* %16, align 4
  br label %71

69:                                               ; preds = %60
  %70 = load i32, i32* %9, align 4
  store i32 %70, i32* %16, align 4
  br label %71

71:                                               ; preds = %69, %67
  store i32 0, i32* %17, align 4
  br label %72

72:                                               ; preds = %86, %71
  %73 = load i32, i32* %17, align 4
  %74 = icmp slt i32 %73, 8
  br i1 %74, label %75, label %89

75:                                               ; preds = %72
  %76 = load i32, i32* %16, align 4
  %77 = load i32, i32* %17, align 4
  %78 = sub nsw i32 7, %77
  %79 = ashr i32 %76, %78
  %80 = and i32 %79, 1
  store i32 %80, i32* %14, align 4
  %81 = load i32, i32* %14, align 4
  %82 = icmp eq i32 %81, 1
  br i1 %82, label %83, label %84

83:                                               ; preds = %75
  call void @i2c_high_sda() #2
  br label %85

84:                                               ; preds = %75
  call void @i2c_low_sda() #2
  br label %85

85:                                               ; preds = %84, %83
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %86

86:                                               ; preds = %85
  %87 = load i32, i32* %17, align 4
  %88 = add nsw i32 %87, 1
  store i32 %88, i32* %17, align 4
  br label %72

89:                                               ; preds = %72
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %90 = load i32*, i32** @mOISC_ior, align 8
  %91 = load volatile i32, i32* %90, align 4
  %92 = and i32 %91, 64
  %93 = ashr i32 %92, 6
  store i32 %93, i32* %12, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  call void @i2c_low_sda() #2
  %94 = load i32, i32* %10, align 4
  %95 = icmp eq i32 %94, 2
  br i1 %95, label %96, label %120

96:                                               ; preds = %89
  %97 = load i32, i32* %9, align 4
  store i32 %97, i32* %16, align 4
  store i32 0, i32* %18, align 4
  br label %98

98:                                               ; preds = %112, %96
  %99 = load i32, i32* %18, align 4
  %100 = icmp slt i32 %99, 8
  br i1 %100, label %101, label %115

101:                                              ; preds = %98
  %102 = load i32, i32* %16, align 4
  %103 = load i32, i32* %18, align 4
  %104 = sub nsw i32 7, %103
  %105 = ashr i32 %102, %104
  %106 = and i32 %105, 1
  store i32 %106, i32* %14, align 4
  %107 = load i32, i32* %14, align 4
  %108 = icmp eq i32 %107, 1
  br i1 %108, label %109, label %110

109:                                              ; preds = %101
  call void @i2c_high_sda() #2
  br label %111

110:                                              ; preds = %101
  call void @i2c_low_sda() #2
  br label %111

111:                                              ; preds = %110, %109
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %112

112:                                              ; preds = %111
  %113 = load i32, i32* %18, align 4
  %114 = add nsw i32 %113, 1
  store i32 %114, i32* %18, align 4
  br label %98

115:                                              ; preds = %98
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %116 = load i32*, i32** @mOISC_ior, align 8
  %117 = load volatile i32, i32* %116, align 4
  %118 = and i32 %117, 64
  %119 = ashr i32 %118, 6
  store i32 %119, i32* %12, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  call void @i2c_low_sda() #2
  br label %120

120:                                              ; preds = %115, %89
  call void @i2c_high_scl() #2
  call void @i2c_high_sda() #2
  ret i32 0
}

; Function Attrs: noinline nounwind optnone uwtable
define void @i2c_read(i32 %0, i32 %1, i32* %2) #0 {
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32*, align 8
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  %12 = alloca i32, align 4
  %13 = alloca i32, align 4
  store i32 %0, i32* %4, align 4
  store i32 %1, i32* %5, align 4
  store i32* %2, i32** %6, align 8
  call void @i2c_low_sda() #2
  call void @i2c_low_scl() #2
  store i32 0, i32* %7, align 4
  %14 = load i32*, i32** @mOISC_ior, align 8
  %15 = load volatile i32, i32* %14, align 4
  store i32 %15, i32* %7, align 4
  store i32 0, i32* %9, align 4
  br label %16

16:                                               ; preds = %30, %3
  %17 = load i32, i32* %9, align 4
  %18 = icmp slt i32 %17, 7
  br i1 %18, label %19, label %33

19:                                               ; preds = %16
  %20 = load i32, i32* %4, align 4
  %21 = load i32, i32* %9, align 4
  %22 = sub nsw i32 6, %21
  %23 = ashr i32 %20, %22
  %24 = and i32 %23, 1
  store i32 %24, i32* %12, align 4
  %25 = load i32, i32* %12, align 4
  %26 = icmp eq i32 %25, 1
  br i1 %26, label %27, label %28

27:                                               ; preds = %19
  call void @i2c_high_sda() #2
  br label %29

28:                                               ; preds = %19
  call void @i2c_low_sda() #2
  br label %29

29:                                               ; preds = %28, %27
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %30

30:                                               ; preds = %29
  %31 = load i32, i32* %9, align 4
  %32 = add nsw i32 %31, 1
  store i32 %32, i32* %9, align 4
  br label %16

33:                                               ; preds = %16
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %34 = load i32*, i32** @mOISC_ior, align 8
  %35 = load volatile i32, i32* %34, align 4
  %36 = and i32 %35, 64
  %37 = ashr i32 %36, 6
  store i32 %37, i32* %8, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  call void @i2c_high_sda() #2
  store i32 0, i32* %13, align 4
  br label %38

38:                                               ; preds = %52, %33
  %39 = load i32, i32* %13, align 4
  %40 = icmp slt i32 %39, 8
  br i1 %40, label %41, label %55

41:                                               ; preds = %38
  %42 = load i32, i32* %5, align 4
  %43 = load i32, i32* %13, align 4
  %44 = sub nsw i32 7, %43
  %45 = ashr i32 %42, %44
  %46 = and i32 %45, 1
  store i32 %46, i32* %12, align 4
  %47 = load i32, i32* %12, align 4
  %48 = icmp eq i32 %47, 1
  br i1 %48, label %49, label %50

49:                                               ; preds = %41
  call void @i2c_high_sda() #2
  br label %51

50:                                               ; preds = %41
  call void @i2c_low_sda() #2
  br label %51

51:                                               ; preds = %50, %49
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %52

52:                                               ; preds = %51
  %53 = load i32, i32* %13, align 4
  %54 = add nsw i32 %53, 1
  store i32 %54, i32* %13, align 4
  br label %38

55:                                               ; preds = %38
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %56 = load i32*, i32** @mOISC_ior, align 8
  %57 = load volatile i32, i32* %56, align 4
  %58 = and i32 %57, 64
  %59 = ashr i32 %58, 6
  store i32 %59, i32* %8, align 4
  call void @i2c_low_scl() #2
  call void @i2c_drive_sda() #2
  call void @i2c_high_sda() #2
  call void @i2c_high_sda() #2
  call void @i2c_high_scl() #2
  call void @i2c_low_sda() #2
  call void @i2c_low_scl() #2
  store i32 0, i32* %9, align 4
  br label %60

60:                                               ; preds = %74, %55
  %61 = load i32, i32* %9, align 4
  %62 = icmp slt i32 %61, 7
  br i1 %62, label %63, label %77

63:                                               ; preds = %60
  %64 = load i32, i32* %4, align 4
  %65 = load i32, i32* %9, align 4
  %66 = sub nsw i32 6, %65
  %67 = ashr i32 %64, %66
  %68 = and i32 %67, 1
  store i32 %68, i32* %12, align 4
  %69 = load i32, i32* %12, align 4
  %70 = icmp eq i32 %69, 1
  br i1 %70, label %71, label %72

71:                                               ; preds = %63
  call void @i2c_high_sda() #2
  br label %73

72:                                               ; preds = %63
  call void @i2c_low_sda() #2
  br label %73

73:                                               ; preds = %72, %71
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  br label %74

74:                                               ; preds = %73
  %75 = load i32, i32* %9, align 4
  %76 = add nsw i32 %75, 1
  store i32 %76, i32* %9, align 4
  br label %60

77:                                               ; preds = %60
  call void @i2c_high_sda() #2
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  call void @i2c_release_sda() #2
  call void @i2c_high_scl() #2
  %78 = load i32*, i32** @mOISC_ior, align 8
  %79 = load volatile i32, i32* %78, align 4
  %80 = and i32 %79, 64
  %81 = ashr i32 %80, 6
  store i32 %81, i32* %8, align 4
  call void @i2c_low_scl() #2
  store i32 0, i32* %11, align 4
  store i32 0, i32* %9, align 4
  br label %82

82:                                               ; preds = %96, %77
  %83 = load i32, i32* %9, align 4
  %84 = icmp slt i32 %83, 8
  br i1 %84, label %85, label %99

85:                                               ; preds = %82
  call void @i2c_high_scl() #2
  %86 = load i32*, i32** @mOISC_ior, align 8
  %87 = load volatile i32, i32* %86, align 4
  %88 = and i32 %87, 64
  %89 = ashr i32 %88, 6
  store i32 %89, i32* %10, align 4
  %90 = load i32, i32* %11, align 4
  %91 = load i32, i32* %10, align 4
  %92 = load i32, i32* %9, align 4
  %93 = sub nsw i32 7, %92
  %94 = shl i32 %91, %93
  %95 = or i32 %90, %94
  store i32 %95, i32* %11, align 4
  call void @i2c_low_scl() #2
  br label %96

96:                                               ; preds = %85
  %97 = load i32, i32* %9, align 4
  %98 = add nsw i32 %97, 1
  store i32 %98, i32* %9, align 4
  br label %82

99:                                               ; preds = %82
  call void @i2c_drive_sda() #2
  call void @i2c_low_sda() #2
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  call void @i2c_release_sda() #2
  %100 = load i32, i32* %11, align 4
  %101 = load i32*, i32** %6, align 8
  %102 = getelementptr inbounds i32, i32* %101, i64 1
  store i32 %100, i32* %102, align 4
  store i32 0, i32* %11, align 4
  store i32 0, i32* %9, align 4
  br label %103

103:                                              ; preds = %117, %99
  %104 = load i32, i32* %9, align 4
  %105 = icmp slt i32 %104, 8
  br i1 %105, label %106, label %120

106:                                              ; preds = %103
  call void @i2c_high_scl() #2
  %107 = load i32*, i32** @mOISC_ior, align 8
  %108 = load volatile i32, i32* %107, align 4
  %109 = and i32 %108, 64
  %110 = ashr i32 %109, 6
  store i32 %110, i32* %10, align 4
  %111 = load i32, i32* %11, align 4
  %112 = load i32, i32* %10, align 4
  %113 = load i32, i32* %9, align 4
  %114 = sub nsw i32 7, %113
  %115 = shl i32 %112, %114
  %116 = or i32 %111, %115
  store i32 %116, i32* %11, align 4
  call void @i2c_low_scl() #2
  br label %117

117:                                              ; preds = %106
  %118 = load i32, i32* %9, align 4
  %119 = add nsw i32 %118, 1
  store i32 %119, i32* %9, align 4
  br label %103

120:                                              ; preds = %103
  call void @i2c_drive_sda() #2
  call void @i2c_high_sda() #2
  call void @i2c_high_scl() #2
  call void @i2c_low_scl() #2
  call void @i2c_low_sda() #2
  %121 = load i32, i32* %11, align 4
  %122 = load i32*, i32** %6, align 8
  %123 = getelementptr inbounds i32, i32* %122, i64 0
  store i32 %121, i32* %123, align 4
  call void @i2c_high_scl() #2
  call void @i2c_high_sda() #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @MAX30205_read(i32* %0) #0 {
  %2 = alloca i32*, align 8
  store i32* %0, i32** %2, align 8
  %3 = load i32*, i32** %2, align 8
  call void @i2c_read(i32 72, i32 0, i32* %3) #2
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @led_init() #0 {
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [2 x i32], align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = bitcast [2 x i32]* %2 to i8*
  call void @llvm.memset.p0i8.i64(i8* align 4 %4, i8 0, i64 8, i1 false)
  store i32 2, i32* %3, align 4
  %5 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %5, align 4
  call void @spiLEDInit() #2
  call void @i2c_init() #2
  %6 = load i32*, i32** @mOISC_ior, align 8
  %7 = load volatile i32, i32* %6, align 4
  %8 = and i32 239, %7
  %9 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %8, i32* %9, align 4
  call void @delay(i32 10) #2
  %10 = load i32*, i32** @mOISC_ior, align 8
  %11 = load volatile i32, i32* %10, align 4
  %12 = or i32 16, %11
  %13 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %12, i32* %13, align 4
  %14 = call i32 @RH_RF95_init() #2
  %15 = icmp eq i32 %14, 0
  br i1 %15, label %16, label %18

16:                                               ; preds = %0
  br label %17

17:                                               ; preds = %16, %17
  br label %17

18:                                               ; preds = %0
  br label %19

19:                                               ; preds = %18, %19
  %20 = getelementptr inbounds [2 x i32], [2 x i32]* %2, i64 0, i64 0
  call void @MAX30205_read(i32* %20) #2
  %21 = getelementptr inbounds [2 x i32], [2 x i32]* %2, i64 0, i64 0
  %22 = load i32, i32* %3, align 4
  %23 = call i32 @RH_RF95_send(i32* %21, i32 %22) #2
  %24 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 0, i32* %24, align 4
  %25 = load i32*, i32** @mOISC_ior, align 8
  %26 = load volatile i32, i32* %25, align 4
  %27 = or i32 32, %26
  %28 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %27, i32* %28, align 4
  call void @delay(i32 1) #2
  %29 = load i32*, i32** @mOISC_ior, align 8
  %30 = load volatile i32, i32* %29, align 4
  %31 = and i32 223, %30
  %32 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %31, i32* %32, align 4
  call void @delay(i32 1) #2
  %33 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %33, align 4
  br label %19
}

; Function Attrs: argmemonly nounwind willreturn writeonly
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { argmemonly nounwind willreturn writeonly }
attributes #2 = { nobuiltin "no-builtins" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 12.0.5 (clang-1205.0.22.11)"}
