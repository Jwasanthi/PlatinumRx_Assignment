def map_feedback(feedback_text):
    feedback_text = feedback_text.lower()

    if "good" in feedback_text or "excellent" in feedback_text:
        return "Positive"
    elif "slow" in feedback_text or "bad" in feedback_text:
        return "Negative"
    elif "quick" in feedback_text or "ok" in feedback_text:
        return "Neutral"
    else:
        return "Unknown"


# Example usage:
print(map_feedback("Good service"))
print(map_feedback("Slow response"))
print(map_feedback("Quick fix"))
