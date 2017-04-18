class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    text_split_into_array = @text.downcase.gsub(",","").gsub(".","").split

    text_without_spaces = @text.gsub(" ", "")

    special_word_downcase = @special_word.downcase

    @word_count = text_split_into_array.count

    @character_count_with_spaces = @text.size

    @character_count_without_spaces = text_without_spaces.size

    @occurrences = text_split_into_array.count (special_word_downcase)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================


    monthly_r = @apr / 12.0 / 100.0
    terms = @years * 12
    numerator = monthly_r * (@principal)
    denominator = 1 - ((1+monthly_r)**-terms)


    @monthly_payment = numerator / denominator

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending - @starting
    @minutes = (@ending - @starting) / 60
    @hours = (@ending - @starting) / 60 / 60
    @days = (@ending - @starting) / 60 / 60 / 24
    @weeks = (@ending - @starting) / 60 / 60 / 24 / 7
    @years = (@ending - @starting) / 60 / 60 / 24 / 365

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================
    #Find median
    if @numbers.count.odd?
      index = (@numbers.count / 2).floor
      med = @numbers.sort[index]
    # Even numbers
    else
      index_1 = (@numbers.count / 2) - 1
      index_2 = (@numbers.count / 2)
      med = (@numbers.sort[index_1] + @numbers.sort[index_2]) / 2.0
    end

    #Find mean
    ave = @numbers.sum / 1.0 / @numbers.count

    #Find variance
    var_math = @numbers.map { |num| (num - ave)**2 / (@numbers.count)}

    #Find mode
    arr = @numbers.sort
    freq = arr.inject(Hash.new(0)) { |h,v| h[v] += 1; h }



    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min

    @median = med

    @sum = @numbers.sum

    @mean = ave

    @variance = var_math.sum

    @standard_deviation = Math.sqrt(var_math.sum)

    @mode = arr.max_by {|v| freq[v]}

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
