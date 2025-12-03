from time_converter import convert_to_24_hour
from duration_calculator import calculate_duration
from feedback_mapper import map_feedback
import pandas as pd

# Load Excel files
tickets_df = pd.read_excel(r"..\ticket.xlsx")
feedbacks_df = pd.read_excel(r"..\feedbacks.xlsx")

# Convert times
tickets_df["created_at_24"] = tickets_df["created_at"].apply(convert_to_24_hour)
tickets_df["closed_at_24"] = tickets_df["closed_at"].apply(convert_to_24_hour)

# Calculate duration
tickets_df["duration_minutes"] = tickets_df.apply(
    lambda row: calculate_duration(row["created_at_24"], row["closed_at_24"]),
    axis=1
)

# Map feedback sentiment
feedbacks_df["sentiment"] = feedbacks_df["feedback"].apply(map_feedback)

# Save results
tickets_df.to_excel("processed_tickets.xlsx", index=False)
feedbacks_df.to_excel("processed_feedbacks.xlsx", index=False)

print("Processing Completed Successfully!")

