//
//  CalendarView.swift
//  Custom Calendar SL
//
//  Created by Mark Perryman on 6/2/24.
//

import SwiftUI

struct CalendarView: View {
	// MARK: - State
	/// I can update this later to use my accentColor
	@State private var color: Color = .accentColor
	@State private var date = Date.now
	@State private var days: [Date] = []
	
	// MARK: - Calendar Stuff
	let daysOfWeek = Date.capitalizedFirstLettersOfWeekdays
	let columns = Array(repeating: GridItem(.flexible()), count: 7)
	
    var body: some View {
        VStack {
			LabeledContent("Calendar Color") {
				ColorPicker("", selection: $color, supportsOpacity: false)
			}
			
			LabeledContent("Date/Time") {
				DatePicker("", selection: $date)
			}
			
			// Calendar Header
			HStack {
				ForEach(daysOfWeek.indices, id: \.self) { index in
					Text(daysOfWeek[index])
						.fontWeight(.black)
						.foregroundStyle(color)
						.frame(maxWidth: .infinity)
				}
			}
			
			LazyVGrid(columns: columns) {
				ForEach(days, id: \.self) { day in
					if day.monthInt != date.monthInt {
						Text("")
					} else {
						Text(day.formatted(.dateTime.day()))
							.fontWeight(.bold)
							.foregroundStyle(.secondary)
							.frame(maxWidth: .infinity, minHeight: 40)
							.background(
								Circle()
									.foregroundStyle(
										Date.now.startOfDay == day.startOfDay ? Color.red.opacity(0.3) :
										color.opacity(0.3)
									)
							)
					}
				}
			}
        }
        .padding()
		.onAppear {
			// Set calendar to correct days to have them start in the correct spot
			days = date.calendarDisplayDays
		}
		.onChange(of: date) {
			// Watch for changes to date to update the calendar view
			days = date.calendarDisplayDays
		}
    }
}

#Preview {
    CalendarView()
}
