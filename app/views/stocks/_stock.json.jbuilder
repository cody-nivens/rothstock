json.extract! stock, :id, :symbol, :name, :industry_id, :sector_id, :ccc_seq, :price, :yield_years, :div_yield, :old_rate, :new_rate, :mr_inc, :ex_div, :div_record, :div_pay, :qtly_sched, :annual_div, :payout, :i_graham, :p_e, :fye_month, :ttm_eps, :peg_ratio, :ttm_p_sales, :mrq_p_book, :ttm_roe, :ty_growth, :ny_growth, :last_5_growth, :est_5_growth, :na, :mktcap, :inside_own, :debt_equity, :chowder_rule, :created_at, :updated_at
json.url stock_url(stock, format: :json)
