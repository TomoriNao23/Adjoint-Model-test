# 变量定义
FC = gfortran
FCFLAGS = -Wall -O2

# 目标文件
TARGET = exe
MODULE = my_module.o
MAIN = main_program.o

# 默认目标
all: $(TARGET)

# 生成目标可执行文件
$(TARGET): $(MODULE) $(MAIN)
	$(FC) $(FCFLAGS) -o $(TARGET) $(MODULE) $(MAIN)

# 生成模块文件
$(MODULE): my_module.f90
	$(FC) $(FCFLAGS) -c my_module.f90

# 生成主程序文件
$(MAIN): main_program.f90
	$(FC) $(FCFLAGS) -c main_program.f90

# 运行程序并将输出重定向到 output.txt
run: $(TARGET)
	./$(TARGET) > ./output.txt 
	@cat output.txt

# 清理生成的文件
clean:
	rm -f $(TARGET) $(MODULE) $(MAIN) output.txt *.mod

.PHONY: all run clean
