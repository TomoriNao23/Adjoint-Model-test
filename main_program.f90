program main
  use my_module
  implicit none
  type(Point) :: p(10)
  integer :: i

  ! Test for Tangent Linear Model
  write(*, '(A)') 'Test for Tangent Linear Model'
  do i = 1, 10
    call p(i)%run_all(i+1)
    write(*, '(A, E8.2, A, F18.15)') 'dx = dy = ', p(i)%dxx, '   Ratio = ', (p(i)%wplus - p(i)%w) / p(i)%dw
  end do
  
  ! Test for Adjoint Model
  write(*, '(/A)') 'Test for Adjoint Model'
  i = 1
  write(*, '(A, E21.15)') 'dw*dw         = ', p(i)%dw ** 2
  write(*, '(A, E21.15)') 'dxx*dx+dyy*dy = ', p(i)%dxx * p(i)%dx + p(i)%dyy * p(i)%dy

end program main