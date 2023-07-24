 # The SQL code to define the model
    definition: >
      with order_amounts as (
        select
          order_id,
          sum(quantity * unit_price) as total_amount
        from
          {{ ref('orders') }}
        group by order_id
      )

      select
        o.order_date as month,
        coalesce(sum(oa.total_amount), 0) as total_revenue
      from
        {{ ref('sales') }} o
      left join
        order_amounts oa on o.order_id = oa.order_id
      group by 1;
