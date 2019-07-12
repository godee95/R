class Student:
    name2 = '1234'
    def getName(self):
        return self.name2
    def setName(self,name):
        self.name2 = name

stu = Student()
stu.getName()
stu.setName("이순신")
stu.getName()