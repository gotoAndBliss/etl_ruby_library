module EtlRubyWrapper
  class ETL
    def binary_path
      path = File.expand_path("../bin/etl_binary/etl_ruby_wrapper", __dir__)
      puts "Computed binary path: #{path}"
      path
    end

    def run_etl(csv_path = "path/to/data.csv", db_conn_str = "your_database_connection_string")
      cmd = "#{binary_path} -csv=#{csv_path} -db='#{db_conn_str}'"
      success = system(cmd)

      unless success
        raise "ETL binary not found or failed to execute"
      end
    end
  end
end
