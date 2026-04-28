"""
Product analytics metrics for event-level e-commerce data.
Run: python src/product_metrics.py
"""
from pathlib import Path
import json, math
import pandas as pd

BASE_DIR = Path(__file__).resolve().parents[1]
DATA_PATH = BASE_DIR / "data" / "events_sample.csv"
REPORTS_DIR = BASE_DIR / "reports"
REPORTS_DIR.mkdir(exist_ok=True)

def two_proportion_z_test(x_a, n_a, x_b, n_b):
    p_a = x_a / n_a
    p_b = x_b / n_b
    p_pool = (x_a + x_b) / (n_a + n_b)
    se = math.sqrt(p_pool * (1 - p_pool) * (1 / n_a + 1 / n_b))
    z = (p_b - p_a) / se
    p_value = 2 * (1 - 0.5 * (1 + math.erf(abs(z) / math.sqrt(2))))
    return {"p_a": p_a, "p_b": p_b, "relative_uplift": p_b / p_a - 1, "z_statistic": z, "p_value": p_value}

def main():
    df = pd.read_csv(DATA_PATH, parse_dates=["event_timestamp", "event_date"])
    steps = ["session_start", "view_item", "add_to_cart", "begin_checkout", "purchase"]
    funnel = df[df["event_name"].isin(steps)].groupby("event_name")["user_id"].nunique().reindex(steps).reset_index()
    funnel.columns = ["step", "users"]
    funnel["step_conversion"] = funnel["users"] / funnel["users"].shift(1)
    funnel.loc[0, "step_conversion"] = 1.0
    funnel["overall_conversion"] = funnel["users"] / funnel.loc[0, "users"]
    funnel.to_csv(REPORTS_DIR / "funnel_metrics.csv", index=False)

    views = df[df["event_name"] == "view_item"].groupby("ab_group")["user_id"].nunique()
    carts = df[df["event_name"] == "add_to_cart"].groupby("ab_group")["user_id"].nunique()
    result = two_proportion_z_test(int(carts["A"]), int(views["A"]), int(carts["B"]), int(views["B"]))
    with open(REPORTS_DIR / "ab_test_result.json", "w", encoding="utf-8") as f:
        json.dump(result, f, indent=2)
    print("Done. Reports saved to reports/.")

if __name__ == "__main__":
    main()
