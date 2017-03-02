require 'puppet'
require 'net/https'
require 'uri'
require 'yaml'

unless Puppet.version.to_i >= '2.6.5'.to_i
  fail "This report processor requires Puppet version 2.6.5 or later"
end

Puppet::Reports.register_report(:pushsafer) do

  configfile = File.join([File.dirname(Puppet.settings[:config]), "pushsafer.yaml"])
  raise(Puppet::ParseError, "Pushsafer report config file #{configfile} not readable") unless File.exist?(configfile)
  @config = YAML.load_file(configfile)
  PRIVATEKEY = @config[:privatekey]

  desc <<-DESC
  Send notification of failed reports to Pushsafer.
  DESC

  def process
    if self.status == 'failed'
      message = "Puppet run for #{self.host} #{self.status} at #{Time.now.asctime}."

      begin
        timeout(8) do
          Puppet.debug "Sending status for #{self.host} to Pushsafer."
          url = URI.parse("https://www.pushsafer.com/api")
          http = Net::HTTP.new(url.host, url.port)
          http.use_ssl = true
          http.verify_mode = OpenSSL::SSL::VERIFY_NONE
          request = Net::HTTP::Post.new(url.request_uri)
          request.set_form_data({
            :k => PRIVATEKEY,
            :t => 'Puppet',
            :m => message
          })
          response = http.request(request)
        end
      rescue Timeout::Error
         Puppet.error "Failed to send report to Pushsafer retrying..."
         max_attempts -= 1
         retry if max_attempts > 0
      end
    end
  end
end
