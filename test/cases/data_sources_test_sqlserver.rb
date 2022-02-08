# frozen_string_literal: true

require "cases/helper_sqlserver"

class ExecuteProcedureTestSQLServer < ActiveRecord::TestCase
  before do
    connection.execute("CREATE SCHEMA dbo1")
    connection.execute("CREATE SCHEMA dbo2")
    connection.execute("CREATE TABLE dbo1.super_employee(EmployeeID INT PRIMARY KEY CLUSTERED)")
    connection.execute("CREATE TABLE dbo2.villain_employee(EmployeeID INT PRIMARY KEY CLUSTERED)")
  end

  after do
    connection.execute("DROP TABLE dbo1.super_employee")
    connection.execute("DROP TABLE dbo2.villain_employee")
    connection.execute("DROP SCHEMA dbo1")
    connection.execute("DROP SCHEMA dbo2")
  end

  it "execute a simple procedure" do
    data_sources = ActiveRecord::Base.connection.data_sources

    assert_includes data_sources, 'super_employee'
    assert_includes data_sources, 'villain_employee'
  end
end
