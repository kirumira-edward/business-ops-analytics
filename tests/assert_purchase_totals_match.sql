-- Verify that purchase totals match between source and fact data
SELECT
    po.PO_ID,
    po.TOTAL_AMOUNT as PO_TOTAL,
    SUM(poi.TOTAL_PRICE) as ITEM_TOTAL,
    ABS(po.TOTAL_AMOUNT - SUM(poi.TOTAL_PRICE)) as DIFFERENCE
FROM {{ source('raw', 'PURCHASE_ORDERS') }} po
JOIN {{ source('raw', 'PURCHASE_ORDER_ITEMS') }} poi ON po.PO_ID = poi.PO_ID
GROUP BY po.PO_ID, po.TOTAL_AMOUNT
HAVING ABS(po.TOTAL_AMOUNT - SUM(poi.TOTAL_PRICE)) > 0.01