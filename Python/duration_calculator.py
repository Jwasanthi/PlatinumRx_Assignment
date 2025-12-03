from datetime import datetime, timedelta

def calculate_duration(start_time_str, end_time_str):
    """
    Calculate duration in minutes between two times in HH:MM 24-hour format.
    Example: '16:45' and '16:55' -> 10.0
    """

    fmt = "%H:%M"

    # Ensure they are strings
    start_str = str(start_time_str)
    end_str = str(end_time_str)

    # Parse as times (we put a dummy date, they are on same day)
    start = datetime.strptime(start_str, fmt)
    end = datetime.strptime(end_str, fmt)

    # If end is earlier than start, assume it crossed midnight
    if end < start:
        end += timedelta(days=1)

    delta = end - start
    return delta.total_seconds() / 60.0
