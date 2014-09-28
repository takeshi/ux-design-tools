require './server/table_sorter'
require './server/db'


describe TableSorter, "TableSorting" do
  it "table sort" do
    # tableSorter = tableSorter.new
    tableColomnSize = 10

    groups = ['a','b','c','d']
    cards = (0...10).to_a
    tableData = [
      [1,3,5,7,8,9],
      [1,2,3,5],
      [4,5,7,9],
      [5,6,7,9]
    ]
    TableSorter.print tableColomnSize,tableData
    p(TableSorter.calV tableColomnSize,tableData)
    p(TableSorter.calH tableColomnSize,tableData)
    p '-----'
    # TableSorter.swapV tableData,1,2
    # TableSorter.print tableColomnSize,tableData
    # p(TableSorter.calV tableColomnSize,tableData)
    # p(TableSorter.calH tableColomnSize,tableData)
    # p '-----'
    # TableSorter.swapH tableData,1,2
    # TableSorter.print tableColomnSize,tableData

    # p(TableSorter.calV tableColomnSize,tableData)
    # p(TableSorter.calH tableColomnSize,tableData)

    p(TableSorter.searchH tableColomnSize,tableData)
    p(TableSorter.searchV tableColomnSize,tableData)
    TableSorter.optimize tableColomnSize,tableData,groups,cards
    TableSorter.print tableColomnSize,tableData
    p groups
    p cards
    
  end
end