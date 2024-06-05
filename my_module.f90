module my_module
  implicit none
  private
  public :: Point

  ! Define the derived type
  type :: Point
    real*8 :: x0, y0, x, y, dx, dy, dxx, dyy, w, dw, wplus
  contains
    procedure ::  initialize_values
    procedure ::  ww
    procedure ::  ww_plus
    procedure ::  intp2tgl
    procedure ::  intp2adj
    procedure ::  run_all
  end type Point

contains
  ! Set test points and reference points
  subroutine initialize_values(this, i)
    class(Point), intent(inout) :: this
    integer, intent(in) :: i

    this%x0 = 0
    this%y0 = 0
    this%x = 2
    this%y = 2
    this%w = 0
    this%wplus = 0
    this%dw = 0
    this%dx = 10**(-1 * real(i, kind=8))
    this%dy = this%dx
    this%dxx = this%dx
    this%dyy = this%dx
  end subroutine initialize_values

  ! Compute ww
  subroutine ww(this)
    class(Point), intent(inout) :: this

    this%w = (this%x - this%x0)**2 + (this%y - this%y0)**2
    this%w = exp(-this%w)
  end subroutine ww

  ! Compute ww_plus
  subroutine ww_plus(this)
    class(Point), intent(inout) :: this

    this%wplus = (this%x + this%dx - this%x0)**2 + (this%y + this%dy- this%y0)**2
    this%wplus = exp(-this%wplus)
  end subroutine ww_plus

  ! Tangent Linear Model
  subroutine intp2tgl(this)
    class(Point), intent(inout) :: this

    this%dw = 2 * (this%x - this%x0) * this%dx + 2 * (this%y - this%y0) * this%dy
    this%dw = -this%w * this%dw
  end subroutine intp2tgl

  ! Adjoint Model
  subroutine intp2adj(this)
    class(Point), intent(inout) :: this
    real*8 :: dww

    dww = -this%w * this%dw
    this%dx = 2 * (this%x - this%x0) * dww
    this%dy = 2 * (this%y - this%y0) * dww
  end subroutine intp2adj

  ! Run all the subroutines
  subroutine run_all(this,i)
    class(Point), intent(inout) :: this
    integer, intent(in) :: i
    call this%initialize_values(i)
    call this%ww()
    call this%ww_plus()
    call this%intp2tgl()
    call this%intp2adj()
  end subroutine run_all

end module my_module
