; ModuleID = 'examples/loratest.c'
source_filename = "examples/loratest.c"
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
  call void @delay(i32 5) #1
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
define void @spiInit() #0 {
  %1 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 251, i32* %1, align 4
  %2 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 8, i32* %2, align 4
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
  %9 = call i32 @spi_ll(i32 %6, i32 %7, i32 %8) #1
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
  %6 = call i32 @spi_ll(i32 %4, i32 %5, i32 0) #1
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
  call void @spiselect() #1
  %7 = load i32, i32* %4, align 4
  %8 = or i32 %7, 128
  call void @spitransaction(i32 %8) #1
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
  call void @spitransaction(i32 %18) #1
  br label %9

19:                                               ; preds = %9
  call void @spiunselect() #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setFrequency_868() #0 {
  %1 = call i32 @spiWrite(i32 6, i32 217) #1
  %2 = call i32 @spiWrite(i32 7, i32 0) #1
  %3 = call i32 @spiWrite(i32 8, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setFrequency_915() #0 {
  %1 = call i32 @spiWrite(i32 6, i32 228) #1
  %2 = call i32 @spiWrite(i32 7, i32 192) #1
  %3 = call i32 @spiWrite(i32 8, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setPreambleLength(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = ashr i32 %3, 8
  %5 = call i32 @spiWrite(i32 32, i32 %4) #1
  %6 = load i32, i32* %2, align 4
  %7 = and i32 %6, 255
  %8 = call i32 @spiWrite(i32 33, i32 %7) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModeIdle() #0 {
  %1 = call i32 @spiWrite(i32 1, i32 1) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw125Cr45Sf128() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 114) #1
  %2 = call i32 @spiWrite(i32 30, i32 116) #1
  %3 = call i32 @spiWrite(i32 38, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw500Cr45Sf128() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 146) #1
  %2 = call i32 @spiWrite(i32 30, i32 116) #1
  %3 = call i32 @spiWrite(i32 38, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw31_25Cr48Sf512() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 72) #1
  %2 = call i32 @spiWrite(i32 30, i32 148) #1
  %3 = call i32 @spiWrite(i32 38, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModemConfig_Bw125Cr48Sf4096() #0 {
  %1 = call i32 @spiWrite(i32 29, i32 120) #1
  %2 = call i32 @spiWrite(i32 30, i32 196) #1
  %3 = call i32 @spiWrite(i32 38, i32 0) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setTxPower(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = sub nsw i32 %3, 5
  %5 = or i32 128, %4
  %6 = call i32 @spiWrite(i32 9, i32 %5) #1
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define void @RH_RF95_setModeTx() #0 {
  %1 = call i32 @spiWrite(i32 1, i32 3) #1
  %2 = call i32 @spiWrite(i32 64, i32 64) #1
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
  call void @RH_RF95_setModeIdle() #1
  %10 = call i32 @spiWrite(i32 13, i32 0) #1
  %11 = call i32 @spiWrite(i32 0, i32 255) #1
  %12 = call i32 @spiWrite(i32 0, i32 255) #1
  %13 = call i32 @spiWrite(i32 0, i32 0) #1
  %14 = call i32 @spiWrite(i32 0, i32 0) #1
  %15 = load i32*, i32** %4, align 8
  %16 = load i32, i32* %5, align 4
  call void @spiBurstWrite(i32 0, i32* %15, i32 %16) #1
  %17 = load i32, i32* %5, align 4
  %18 = add nsw i32 %17, 4
  %19 = call i32 @spiWrite(i32 34, i32 %18) #1
  call void @RH_RF95_setModeTx() #1
  br label %20

20:                                               ; preds = %24, %9
  %21 = call i32 @spiRead(i32 18) #1
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
  %2 = call i32 @spiWrite(i32 1, i32 128) #1
  call void @delay(i32 200) #1
  %3 = call i32 @spiRead(i32 1) #1
  %4 = icmp ne i32 %3, 128
  br i1 %4, label %5, label %6

5:                                                ; preds = %0
  store i32 0, i32* %1, align 4
  br label %9

6:                                                ; preds = %0
  %7 = call i32 @spiWrite(i32 14, i32 0) #1
  %8 = call i32 @spiWrite(i32 15, i32 0) #1
  call void @RH_RF95_setModeIdle() #1
  call void @RH_RF95_setModemConfig_Bw125Cr45Sf128() #1
  call void @RH_RF95_setPreambleLength(i32 8) #1
  call void @RH_RF95_setFrequency_868() #1
  call void @RH_RF95_setTxPower(i32 13) #1
  store i32 1, i32* %1, align 4
  br label %9

9:                                                ; preds = %6, %5
  %10 = load i32, i32* %1, align 4
  ret i32 %10
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca [7 x i32], align 16
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %7 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 64, i32* %7, align 4
  call void @spiInit() #1
  %8 = load i32*, i32** @mOISC_ior, align 8
  %9 = load volatile i32, i32* %8, align 4
  %10 = and i32 239, %9
  %11 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %10, i32* %11, align 4
  call void @delay(i32 10) #1
  %12 = load i32*, i32** @mOISC_ior, align 8
  %13 = load volatile i32, i32* %12, align 4
  %14 = or i32 16, %13
  %15 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %14, i32* %15, align 4
  %16 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %16, align 4
  %17 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 6
  store i32 72, i32* %17, align 8
  %18 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 5
  store i32 101, i32* %18, align 4
  %19 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 4
  store i32 108, i32* %19, align 16
  %20 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 3
  store i32 108, i32* %20, align 4
  %21 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 2
  store i32 111, i32* %21, align 8
  %22 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 1
  store i32 33, i32* %22, align 4
  %23 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 0
  store i32 32, i32* %23, align 16
  store i32 0, i32* %4, align 4
  store i32 65, i32* %5, align 4
  store i32 7, i32* %6, align 4
  %24 = call i32 @RH_RF95_init() #1
  %25 = icmp eq i32 %24, 0
  br i1 %25, label %26, label %29

26:                                               ; preds = %0
  %27 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 136, i32* %27, align 4
  br label %28

28:                                               ; preds = %26, %28
  br label %28

29:                                               ; preds = %0
  br label %30

30:                                               ; preds = %29, %51
  %31 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 0
  %32 = load i32, i32* %6, align 4
  %33 = call i32 @RH_RF95_send(i32* %31, i32 %32) #1
  %34 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 0, i32* %34, align 4
  %35 = load i32*, i32** @mOISC_ior, align 8
  %36 = load volatile i32, i32* %35, align 4
  %37 = or i32 32, %36
  %38 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %37, i32* %38, align 4
  call void @delay(i32 1) #1
  %39 = load i32*, i32** @mOISC_ior, align 8
  %40 = load volatile i32, i32* %39, align 4
  %41 = and i32 223, %40
  %42 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %41, i32* %42, align 4
  call void @delay(i32 1) #1
  %43 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %43, align 4
  %44 = load i32, i32* %5, align 4
  %45 = getelementptr inbounds [7 x i32], [7 x i32]* %2, i64 0, i64 0
  store i32 %44, i32* %45, align 16
  %46 = load i32, i32* %5, align 4
  %47 = add nsw i32 %46, 1
  store i32 %47, i32* %5, align 4
  %48 = load i32, i32* %5, align 4
  %49 = icmp sgt i32 %48, 90
  br i1 %49, label %50, label %51

50:                                               ; preds = %30
  store i32 65, i32* %5, align 4
  br label %51

51:                                               ; preds = %50, %30
  br label %30
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin "no-builtins" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 12.0.5 (clang-1205.0.22.9)"}
