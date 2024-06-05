program main
  use my_module
  implicit none

  type(Point) :: p(9)
  integer :: i

  ! Test for Tangent Linear Model
  print *, 'Test for Tangent Linear Model'
  do i = 2, 10
    call p(i-1)%initialize(i)
    call p(i-1)%compute_ww()
    call p(i-1)%compute_wwplus()
    call p(i-1)%tangent_linear_model()
    write(*, '(A, E8.2, A, F18.15)') 'dx = dy = ', p(i-1)%dxx, '   Ratio = ', (p(i-1)%wplus - p(i-1)%w) / p(i-1)%dw
  end do
  
  ! Test for Adjoint Model
  print *, ' '
  print *, 'Test for Adjoint Model'
  i = 9
  call p(i-1)%tangent_linear_model()
  print *,p(i-1)%dw
  write(*, '(A, E21.15)') 'dw*dw         = ', p(i-1)%dw * p(i-1)%dw 
  call p(i-1)%adjoint_model()
  write(*, '(A, E21.15)') 'dxx*dx+dyy*dy = ', abs(p(i-1)%dxx * p(i-1)%dx + p(i-1)%dyy * p(i-1)%dy)

end program main