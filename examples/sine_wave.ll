; ModuleID = 'examples/sine_wave.c'
source_filename = "examples/sine_wave.c"
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
@sine = constant [64 x i32] [i32 127, i32 140, i32 152, i32 165, i32 177, i32 188, i32 199, i32 209, i32 218, i32 227, i32 234, i32 241, i32 246, i32 250, i32 253, i32 254, i32 254, i32 253, i32 251, i32 248, i32 243, i32 237, i32 230, i32 222, i32 213, i32 203, i32 193, i32 181, i32 170, i32 158, i32 145, i32 132, i32 120, i32 107, i32 94, i32 82, i32 71, i32 59, i32 49, i32 39, i32 31, i32 23, i32 16, i32 10, i32 6, i32 2, i32 0, i32 0, i32 0, i32 2, i32 5, i32 9, i32 14, i32 21, i32 28, i32 37, i32 47, i32 57, i32 68, i32 79, i32 91, i32 104, i32 116, i32 129], align 16
@direction = global i32 0, align 4

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
define i32 @sleep(i32 %0, i32 %1) #0 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  store i32 %1, i32* %4, align 4
  store i32 1, i32* %5, align 4
  br label %6

6:                                                ; preds = %11, %2
  %7 = load i32, i32* %5, align 4
  %8 = load i32, i32* %3, align 4
  %9 = icmp sle i32 %7, %8
  br i1 %9, label %10, label %14

10:                                               ; preds = %6
  br label %11

11:                                               ; preds = %10
  %12 = load i32, i32* %5, align 4
  %13 = add nsw i32 %12, 1
  store i32 %13, i32* %5, align 4
  br label %6

14:                                               ; preds = %6
  %15 = load i32, i32* %4, align 4
  %16 = icmp sgt i32 %15, 128
  br i1 %16, label %17, label %18

17:                                               ; preds = %14
  store i32 1, i32* @direction, align 4
  br label %18

18:                                               ; preds = %17, %14
  %19 = load i32, i32* %4, align 4
  %20 = icmp slt i32 %19, 0
  br i1 %20, label %21, label %22

21:                                               ; preds = %18
  store i32 0, i32* @direction, align 4
  br label %22

22:                                               ; preds = %21, %18
  %23 = load i32, i32* @direction, align 4
  %24 = icmp eq i32 %23, 1
  br i1 %24, label %25, label %28

25:                                               ; preds = %22
  %26 = load i32, i32* %4, align 4
  %27 = add nsw i32 %26, -1
  store i32 %27, i32* %4, align 4
  br label %31

28:                                               ; preds = %22
  %29 = load i32, i32* %4, align 4
  %30 = add nsw i32 %29, 1
  store i32 %30, i32* %4, align 4
  br label %31

31:                                               ; preds = %28, %25
  %32 = load i32, i32* %4, align 4
  ret i32 %32
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %5 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %5, align 4
  %6 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 255, i32* %6, align 4
  store i32 0, i32* %2, align 4
  store i32 0, i32* %3, align 4
  br label %7

7:                                                ; preds = %0, %7
  %8 = load i32, i32* %2, align 4
  %9 = sext i32 %8 to i64
  %10 = getelementptr inbounds [64 x i32], [64 x i32]* @sine, i64 0, i64 %9
  %11 = load i32, i32* %10, align 4
  %12 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %11, i32* %12, align 4
  %13 = load i32, i32* %2, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %2, align 4
  %15 = load i32, i32* %3, align 4
  %16 = load i32, i32* %3, align 4
  %17 = call i32 @sleep(i32 %15, i32 %16) #1
  store i32 %17, i32* %3, align 4
  %18 = load i32, i32* %2, align 4
  %19 = and i32 %18, 63
  store i32 %19, i32* %2, align 4
  br label %7
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin "no-builtins" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 12.0.5 (clang-1205.0.22.11)"}
