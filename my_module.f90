module my_module
  implicit none
contains

  ! Tangent Linear Model
  function qiexianxin(dx, dy, x, y, x0, y0) result(dw2)
    implicit none
    real :: dx, dy, x, y, x0, y0
    real :: w1, dw1, w2, dw2
    
    w1 = (x - x0)**2 + (y - y0)**2
    dw1 = 2.0 * (x - x0) * dx + 2.0 * (y - y0) * dy
    
    w2 = exp(-w1)
    dw2 = exp(-w1) * dw1
  end function qiexianxin

  ! Adjoint Model
  subroutine bansui(dw2, x, y, x0, y0, dx, dy)
    implicit none
    real :: dw2, x, y, x0, y0
    real :: w1, w2, dw1
    real :: dx, dy
    
    w1 = (x - x0)**2 + (y - y0)**2
    w2 = exp(-w1)
    
    dw1 = exp(-w1) * dw2
    
    dx = 2.0 * (x - x0) * dw1
    dy = 2.0 * (y - y0) * dw1
  end subroutine bansui

end module my_module
