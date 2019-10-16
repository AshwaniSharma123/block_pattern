//imports
//list of employee
//stream controller
//stream sink getters
//constructor - add data;listen to change
//core functions
//dispose

import 'dart:async';
import 'Employee.dart';

class EmployeeBloc {
 
 //sink to add in pipe
 //stream to get data flow pipe
 // pipe  mean data flow

List<Employee> _employeeList = [
Employee(1,"Emp 1",10000.0),
Employee(2,"Emp 2",20000.0),
Employee(3,"Emp 3",30000.0),
Employee(4,"Emp 4",40000.0),
Employee(5,"Emp 5",50000.0),
Employee(6,"Emp 6",60000.0),
Employee(7,"Emp 7",70000.0),
Employee(8,"Emp 8",80000.0),
Employee(9,"Emp 9",90000.0),
Employee(10,"Emp 10",100000.0),
Employee(11,"Emp 11",11000.0),
];

final _employeeListStreamController = StreamController<List<Employee>>();

//for increment and decrement.

final _employeeSalaryIncrementStreamController = StreamController<Employee>();
final _employeeSalaryDecrementStreamController = StreamController<Employee>();

//getters

 Stream<List<Employee>> get employeeListStream => 
_employeeListStreamController.stream;

 StreamSink<List<Employee>> get employeeListSink =>
_employeeListStreamController.sink;

 StreamSink<Employee> get employeeSalaryIncrement => 
_employeeSalaryIncrementStreamController.sink; 

  StreamSink<Employee> get employeeSalaryDecrement => 
_employeeSalaryDecrementStreamController.sink;

//Constructors

EmployeeBloc(){

_employeeListStreamController.add(_employeeList);

_employeeSalaryIncrementStreamController.stream.listen(_incrementSalary);
_employeeSalaryDecrementStreamController.stream.listen(_decrementSalary);

}

//Core Functions

_incrementSalary(Employee employee){

double salary = employee.salary;
double incrementedSalary = salary * 20/100;
_employeeList[employee.id -1].salary = salary + incrementedSalary;

employeeListSink.add(_employeeList);
}

_decrementSalary(Employee employee){
double salary = employee.salary;
double decrementedSalary = salary * 20/100;

_employeeList[employee.id -1].salary = salary - decrementedSalary;

employeeListSink.add(_employeeList);
}
//dispose
void dispose(){
  _employeeSalaryIncrementStreamController.close();
  _employeeSalaryDecrementStreamController.close();
  _employeeListStreamController.close();
}
}