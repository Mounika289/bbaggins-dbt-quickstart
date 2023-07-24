select
        o.order_date as month,
        coalesce(sum(oa.total_amount), 0) as total_revenue
      from
        {{ ref('sales') }} o
      left join
        order_amounts oa on o.order_id = oa.order_id
      group by 1;