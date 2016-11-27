# Sign Tweakers
# --------------------------------------------------------------------
# Given a perfectly respectable business sign, determine if pranksters
# George and Harold can make a vandalized sign out of it using the same
# or fewer letters. Ignore capitalization and punctuation.

def can_tweak_sign?(normal_sign, vandalized_sign)
  norm_sign_count = Hash.new(0)
  vand_sign_count = Hash.new(0)

  normal_sign.split(" ").each do |word|
    word.each_char { |char| norm_sign_count[char.downcase] += 1 }
  end

  vandalized_sign.split(" ").each do |word|
    word.each_char { |char| vand_sign_count[char.downcase] += 1 }
  end

  vand_sign_count.each_pair do |key, val|
    # The normal sign can't have fewer instances of a letter
    return false if norm_sign_count[key] < val
  end

  true
end

puts "-------Sign Tweakers-------"
puts can_tweak_sign?("Come in and see our pretty armchairs", "Come and see our hairy armpits") == true
puts can_tweak_sign?("Student and teacher art fair starts Wed.", "Teacher farts stain underwear") == true
puts can_tweak_sign?("Choose the bread of life or you are toast", "Teacher farts stain underwear") == false



# Repeated Number Ranges
# ---------------------------------------------------------------------
# Given a list of numbers, give the start and end indices each time a
# number shows up multiple times in a row.

def repeated_number_ranges(numbers)
  ranges = []
  current_index = 0
  start_index = nil

  while current_index < numbers.length
    if numbers[current_index + 1] == numbers[current_index]
      start_index = current_index if start_index.nil?
    else
      if !start_index.nil?
        ranges.push([start_index, current_index])
        start_index = nil
      end
    end

    current_index += 1
  end

  ranges
end

puts "-------Repeated Number Ranges-------"
puts repeated_number_ranges([1, 1, 2]) == [[0, 1]]
puts repeated_number_ranges([1, 2, 3, 3, 4]) == [[2, 3]]
puts repeated_number_ranges([1, 2, 3, 3, 4, 4]) == [[2, 3], [4, 5]]
puts repeated_number_ranges([1, 1, 1, 2, 3, 3, 4]) == [[0, 2], [4, 5]]
puts repeated_number_ranges([8, 7, 7, 14, 12, 12, 12, 12, 21]) == [[1, 2], [4, 7]]



# Time Sums
# ---------------------------------------------------------------------
# Return an array of all the minutes of the day whose digits sum to N.
#
# Use military time, so 1:00 PM is really 13:00 PM.
# ---------------------------------------------------------------------

def time_sums(n)
  result = []

  (0..23).each do |hour|
    (0..59).each do |minute|
      if sum_time("#{hour}:#{minute}") == n
        result << "#{clock_time(hour)}:#{clock_time(minute)}"
      end
    end
  end

  result
end

def clock_time(n)
  if n < 10
    "0#{n}"
  else
    "#{n}"
  end
end

def sum_time(time)
  time.delete(":")
  time.split("").reduce(0) { |sum, num| sum += num.to_i }
end

puts "------Time Sums------"

puts time_sums(0) == ["00:00"]
puts time_sums(1) == ["00:01", "00:10", "01:00", "10:00"]
puts time_sums(23) == ["09:59", "18:59", "19:49", "19:58"]
puts time_sums(24) == ["19:59"]



# Fall and Winter Birthdays
# ------------------------------------------------------------------
# Given a list of students and what month their birthday is, return all
# the pairs of students whose birthdays both fall in the second half of
# the year.  Months are numbers, and assume that July (month 7) and
# later is the second half of the year.
#
# Only count pairs once, and work from the beginning of the list to the
# end.

def fall_and_winter_birthdays(students_with_birthdays)
  result = []

  (0...students_with_birthdays.length - 1).each do |ind_1|
    (ind_1 + 1...students_with_birthdays.length).each do |ind_2|
      if students_with_birthdays[ind_1][1] >= 7 && students_with_birthdays[ind_2][1] >= 7
        result << [students_with_birthdays[ind_1][0], students_with_birthdays[ind_2][0]]
      end
    end
  end

  result
end

students_with_birthdays_1 = [
  ["Asher", 6],
  ["Bertie", 11],
  ["Dottie", 8],
  ["Warren", 9]
]

second_half_birthday_pairs_1 = [
  ["Bertie", "Dottie"],
  ["Bertie", "Warren"],
  ["Dottie", "Warren"]
]

students_with_birthdays_2 = [
  ["Asher", 6],
  ["Bertie", 11],
  ["Dottie", 8],
  ["Warren", 9],
  ["Charlie", 7],
  ["Nassim", 4],
  ["Ajit", 10],
]

second_half_birthday_pairs_2 = [
  ["Bertie", "Dottie"],
  ["Bertie", "Warren"],
  ["Bertie", "Charlie"],
  ["Bertie", "Ajit"],
  ["Dottie", "Warren"],
  ["Dottie", "Charlie"],
  ["Dottie", "Ajit"],
  ["Warren", "Charlie"],
  ["Warren", "Ajit"],
  ["Charlie", "Ajit"],
]

puts "-------Fall and Winter Birthdays-------"
puts fall_and_winter_birthdays(students_with_birthdays_1) == second_half_birthday_pairs_1
puts fall_and_winter_birthdays(students_with_birthdays_2) == second_half_birthday_pairs_2



# Care Bear Summary
# ---------------------------------------------------------------------
# You have a calendar of hugs that care bears made (given as a list of
# names by care bears).  Some of them have hugged multiple
# times in a row.
#
# Return a hash where the keys are the care bears and the values are an
# array of all of the start and end days of their hugging streaks.
#
# Days are the index of the calendar array.

def care_bear_summary(calendar_of_hugs)
  result = Hash.new { |h, k| h[k] = [] }
  cur_streak = []

  (0...calendar_of_hugs.length - 1).each do |i|
    if calendar_of_hugs[i] == calendar_of_hugs[i + 1]
      cur_streak << i if cur_streak.empty?
    elsif calendar_of_hugs[i] != calendar_of_hugs[i + 1]
      if cur_streak.length == 1
        cur_streak << i
        result[calendar_of_hugs[i]] << cur_streak
        cur_streak = Array.new
      end
    end
  end

  result
end

puts "-------Care Bear Summary-------"

hug_calendar_1 = [
  "Birthday Bear",
  "Bedtime Bear",
  "Birthday Bear",
  "Birthday Bear",
  "Bedtime Bear"
]

care_bear_counts_1 = {
  "Birthday Bear" => [[2, 3]]
}

hug_calendar_2 = [
  "Birthday Bear",
  "Birthday Bear",
  "Cheer Bear",
  "Bedtime Bear",
  "Bedtime Bear",
  "Birthday Bear",
  "Birthday Bear",
  "Birthday Bear",
  "Bedtime Bear",
  "Friend Bear"
]

care_bear_counts_2 = {
  "Birthday Bear" => [[0, 1], [5, 7]],
  "Bedtime Bear" => [[3, 4]]
}

puts care_bear_summary(hug_calendar_1) == care_bear_counts_1
puts care_bear_summary(hug_calendar_2) == care_bear_counts_2
