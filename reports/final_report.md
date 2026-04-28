# Final report: E-commerce product analytics

## 1. Goal

Find weak points in the e-commerce funnel, estimate retention, compare acquisition channels and test a product hypothesis about improving the product card.

## 2. Main metrics

| Metric | Value |
|---|---:|
| Users | 2,000 |
| Sessions | 8,070 |
| Orders | 659 |
| Revenue | 3,612,797 |
| AOV | 5,482 |
| ARPU | 1,806 |
| ARPPU | 6,740 |

## 3. Funnel

Funnel: session_start -> view_item -> add_to_cart -> begin_checkout -> purchase.

Main optimization point: view_item -> add_to_cart.

## 4. A/B hypothesis

Hypothesis: a new product card version increases view_item -> add_to_cart conversion.

- conversion A: 52.70%
- conversion B: 55.99%
- relative uplift: 6.24%
- p-value: 0.1478

## 5. Product recommendations

1. Focus on view_item -> add_to_cart.
2. Improve the product card: reviews, delivery details, stock status, price communication and recommendations.
3. Split the effect by traffic source and device.
4. Run a controlled A/B test with add_to_cart conversion as primary metric.
5. Monitor guardrail metrics: purchase conversion, AOV and revenue per user.
