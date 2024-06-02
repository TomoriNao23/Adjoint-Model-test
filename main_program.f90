program main
    use my_module
    implicit none
  
    real :: x, y, x0, y0, dx, dy, dw2_result
    
    ! Initialize variables
    x = 1.0
    y = 2.0
    x0 = 0.5
    y0 = 1.5
    dx = 0.1
    dy = 0.2
  
    ! Call functions and subroutine
    dw2_result = qiexianxin(dx, dy, x, y, x0, y0)
    print *, "dw2 = ", dw2_result
  
    call bansui(dw2_result, x, y, x0, y0, dx, dy)
    print *, "dx = ", dx, ", dy = ", dy
  
  end program main