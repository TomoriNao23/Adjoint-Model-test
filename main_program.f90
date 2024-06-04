program main
  use my_module
  implicit none
  real*8 dx, dy, x, y, x0, y0                                                  
  real*8 dw, w                                  
  real*8 dxx, dyy, result
  integer i
  
  !切线性检验
    print *, 'Test for Tangent Linear Model'
    do i = 2,10
      ! 设置测试点和参考点
        call initialize_values(x0, y0, x, y, dx, dy, dxx, dyy, w, dw, i)
      ! 调用切线性子程序
        call ww(x+dx, y+dy, x0, y0, w)
        result = w
        call ww(x, y, x0, y0, w)
        call intp2tgl(dx, dy, x, y, x0, y0,w, dw)
        result = (w - result) / dw
        write(*, '(A, E8.2, A, F18.15)') 'dx = dy = ', dxx, '   Ratio = ', result
      end do
  
  !伴随检验
    print *, ' '
    print *, 'Test for Adjoint Model'
    call intp2tgl(dx, dy, x, y, x0, y0,w, dw)
    write(*, '(A, E21.15)') 'dw*dw         = ', dw * dw 
    call intp2adj(dxx, dyy, x, y, x0, y0,w, dw)
    write(*, '(A, E21.15)') 'dxx*dx+dyy*dy = ', abs(dxx * dx + dyy * dy)

end program main