class TableSorter

  def self.print size,tableData
    tableData.each do |e|
    s = ''
    for i in 0...size
      s += if e.any?{|e| e == i}
          '1'
        else
          '0'
        end
      end
      p s
    end
  end

  def self.swap tableData,x,y
    self.swapV tableData,x,y
  end
  def self.swapV tableData,x,y
    tmp = tableData[x]
    tableData[x] = tableData[y]
    tableData[y] = tmp
  end

  def self.calV size,tableData
    value = 0
    for i in 0...size
      min = nil
      max = nil
      for j in 0...tableData.length
        found = tableData[j].any?{|e| e == i}
        if found
          if min == nil
            min = j
          end
          max = j
        end
      end
      value += max - min if max
    end
    value
  end


  def self.calH size,tableData
    value = 0
    tableData.each do |t|
      value += t.max - t.min
    end
    value
  end

  def self.swapH tableData,x,y
    tableData.each do |t|
      # p t
      ix = t.index(x)
      iy = t.index(y)
      if ix  != nil
        t[ix] = y
      end
      if iy != nil
        t[iy] = x
      end
    end
  end

  def self.searchV size,tableData
    minValue = nil;
    minX = nil
    minY = nil
    (0...tableData.length).to_a.combination(2) do |x,y|
      # p tableData
      swapV(tableData,x,y)
      # p tableData
      value = calV(size,tableData)
      if minValue == nil|| minValue > value
        minValue = value
        minX = x
        minY = y
      end
      # p ['searchV',value,x,y]
      swapV(tableData,y,x)
    end
    [minValue,minX,minY]
  end
  def self.searchH size,tableData
    minValue = nil;
    minX = nil
    minY = nil
    (0...size).to_a.combination(2) do |x,y|
      swapH(tableData,x,y)
      value = calH(size,tableData)
      if minValue == nil|| minValue > value
        minValue = value
        minX = x
        minY = y
      end
      # p [value,x,y]
      swapH(tableData,y,x)
    end
    [minValue,minX,minY]
  end

  def self.optimize size,tableData,h,v,logger
    calH = self.calH(size,tableData)
    calV = self.calV(size,tableData)
    logger.info "data #{size} #{tableData} #{calH} #{calV}"

    loop{
      p [calH,calV]
      # self.print size,tableData
      # p '^^^^^^^^'
      result = searchH(size,tableData)
      if(result[0] < calH)
        calH = self.calH(size,tableData)
        calV = self.calV(size,tableData)
        swapH(tableData,result[1],result[2])
        swap v,result[1],result[2]
        # p calV,calH,tableData
        logger.info "v #{result[1]} #{result[2]}"
        next
      end

      result = searchV(size,tableData)
      if(result[0] < calV)
        calH = self.calH(size,tableData)
        calV = self.calV(size,tableData)
        swapV(tableData,result[1],result[2])
        swap h,result[1],result[2]
        logger.info "h #{result[1]} #{result[2]}"

        # p calV,calH,tableData
        next
      end

      break
    }
  end

  def initialize list

  end

end