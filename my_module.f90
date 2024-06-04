module my_module
  implicit none
contains
  ! 设置测试点和参考点
    subroutine initialize_values(x0, y0, x, y, dx, dy, dxx, dyy, w, dw, i)
      implicit none
      integer, intent(in) :: i
      real*8, intent(out) :: x0, y0, x, y, dx, dy, dxx, dyy, w, dw

      x0 = 0
      y0 = 0
      x = 2
      y = 2
      dx = 10**(-1 * real(i, kind=8))
      dy = dx
      dxx = dx
      dyy = dx
      w = 0
      dw = 0
      return
    end

  ! 计算ww
    subroutine ww(x, y, x0, y0, w)
      implicit none
      real*8  x, y, x0, y0                                                                                  
      real*8 w  

      w = (x - x0)**2 + (y - y0)**2
      w = exp(-w)
      return
    end

  ! Tangent Linear Model
    subroutine intp2tgl(dx, dy, x, y, x0, y0,w, dw)
      implicit none
      real*8 dx, dy, x, y, x0, y0                                                  
      real*8 dw                                  
      real*8 w                              

      !w = (x - x0)**2 + (y - y0)**2
      dw = 2 * (x - x0) * dx + 2 * (y - y0) * dy
      !w = exp(-w)
      dw = -w * dw
      return
    end

  ! Adjoint Model
    subroutine intp2adj(dx, dy, x, y, x0, y0, w, dw)
      implicit none
      real*8 dx, dy, x, y, x0, y0                                                  
      real*8 dw, dww                                  
      real*8 w   

      dww = w * dw 
      dx = 2 * (x - x0) * dww
      dy = 2 * (y - y0) * dww
      return
    end

end module my_module
