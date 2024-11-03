require 'spec_helper'

RSpec.describe EtlRubyWrapper::ETL do
  let(:wrapper) { EtlRubyWrapper::ETL.new }
  let(:csv_path) { File.expand_path("fixtures/data.csv", __dir__) }
  let(:db_conn_str) { "user=testuser dbname=testdb sslmode=disable" }

  it "should find the correct binary path based on the platform" do
    path = wrapper.binary_path
    expect(File).to exist(path) # Checks if the binary path exists
  end

  it "runs the ETL binary successfully with valid inputs" do
    ENV["NO_DB"] = "true"
    # Run the binary and check for success
    expect { wrapper.run_etl(csv_path, db_conn_str) }.not_to raise_error

    ENV.delete("NO_DB")
  end

  it "raises an error if the binary cannot be found" do
    # Stub binary_path to a nonexistent path to simulate missing binary
    allow(wrapper).to receive(:binary_path).and_return("non_existent_path")
    expect { wrapper.run_etl(csv_path, db_conn_str) }.to raise_error("ETL binary not found or failed to execute")
  end
end
