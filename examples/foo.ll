; ModuleID = 'examples/foo.c'
source_filename = "examples/foo.c"
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
define void @foo(i32 %0) #0 {
  %2 = alloca i32, align 4
  store i32 %0, i32* %2, align 4
  %3 = load i32, i32* %2, align 4
  %4 = load i32*, i32** @mOISC_ior, align 8
  store volatile i32 %3, i32* %4, align 4
  ret void
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  %4 = load i32*, i32** @mOISC_csr, align 8
  store volatile i32 192, i32* %4, align 4
  %5 = load i32*, i32** @mOISC_idr, align 8
  store volatile i32 255, i32* %5, align 4
  br label %6

6:                                                ; preds = %0, %15
  store i32 0, i32* %3, align 4
  br label %7

7:                                                ; preds = %12, %6
  %8 = load i32, i32* %3, align 4
  %9 = icmp sle i32 %8, 10
  br i1 %9, label %10, label %15

10:                                               ; preds = %7
  %11 = load i32, i32* %3, align 4
  call void @foo(i32 %11) #1
  br label %12

12:                                               ; preds = %10
  %13 = load i32, i32* %3, align 4
  %14 = add nsw i32 %13, 1
  store i32 %14, i32* %3, align 4
  br label %7

15:                                               ; preds = %7
  br label %6
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "darwin-stkchk-strong-link" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-builtins" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "probe-stack"="___chkstk_darwin" "stack-protector-buffer-size"="8" "target-cpu"="penryn" "target-features"="+cx16,+cx8,+fxsr,+mmx,+sahf,+sse,+sse2,+sse3,+sse4.1,+ssse3,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nobuiltin "no-builtins" }

!llvm.module.flags = !{!0, !1, !2}
!llvm.ident = !{!3}

!0 = !{i32 2, !"SDK Version", [2 x i32] [i32 11, i32 3]}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 7, !"PIC Level", i32 2}
!3 = !{!"Apple clang version 12.0.5 (clang-1205.0.22.9)"}
