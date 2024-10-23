local http = require "resty.http"
local httpc = http.new()

-- Fetch the original metrics from your application's metrics endpoint
local res, err = httpc:request_uri("https://monolithic.anykey.pl/metrics/", {
    method = "GET",
})

if not res then
    ngx.log(ngx.ERR, "Failed to fetch metrics: ", err)
    ngx.exit(500)
end

-- Function to filter out unwanted metrics
local function filter_metrics(metrics)
    local filtered = {}
    for line in metrics:gmatch("[^\r\n]+") do
        -- Exclude lines containing specific metric names
        if not (line:match("^# HELP python_gc_objects_collected_total") or
                line:match("^# TYPE python_gc_objects_collected_total") or
                line:match("^python_gc_objects_collected_total") or
                line:match("^# HELP python_gc_objects_uncollectable_total") or
                line:match("^# TYPE python_gc_objects_uncollectable_total") or
                line:match("^python_gc_objects_uncollectable_total")) then
            table.insert(filtered, line)
        end
    end
    return table.concat(filtered, "\n")
end

-- Filter the metrics
local filtered_metrics = filter_metrics(res.body)

-- Output the filtered metrics
ngx.say(filtered_metrics)
