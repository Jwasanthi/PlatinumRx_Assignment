from datetime import datetime

def convert_to_24_hour(time_val):
    # If it's already a datetime object → return HH:MM
    if isinstance(time_val, datetime):
        return time_val.strftime("%H:%M")

    # Otherwise, convert from string
    time_str = str(time_val)
    time, period = time_str.split()
    hours, minutes = map(int, time.split(':'))

    if period.upper() == "PM" and hours != 12:
        hours += 12
    elif period.upper() == "AM" and hours == 12:
        hours = 0

    return f"{hours:02d}:{minutes:02d}"


